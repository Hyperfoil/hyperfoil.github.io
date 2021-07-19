---
---
# Deploying in Kubernetes/Openshift

A convenient alternative to running Hyperfoil on hosts with SSH access is deploying it in Kubernetes or Openshift. The recommended way to install it using an operator in your Openshift console - just go to Operators - OperatorHub and search for 'hyperfoil', and follow the installation wizard. Alternatively you can [deploy the controller manually]({{ "/userguide/installation/k8s_manual.html" | absolute_url }})

In order to start a Hyperfoil Controller instance in your cluster, create a new namespace `hyperfoil`: Go to Operators - Installed Operators and open Hyperfoil. In upper left corner select 'Project: ' - Create project and fill out the details. Then click on the 'Hyperfoil' tab and find the button 'Create Hyperfoil'.

You should see a YAML definition like this:

```yaml
apiVersion: hyperfoil.io/v1alpha2
kind: Hyperfoil
metadata:
  name: example-hyperfoil
  namespace: hyperfoil
spec:
  agentDeployTimeout: 60000
  log: myConfigMap/log4j2-superverbose.xml
  route:
    host: hyperfoil.apps.mycloud.example.com
  version: latest
```

Change the `name` to just `hyperfoil` (or whatever you prefer) and delete all the content from the `spec` section:

```yaml
apiVersion: hyperfoil.io/v1alpha2
kind: Hyperfoil
metadata:
  name: hyperfoil
  namespace: hyperfoil
spec:
```

This is a perfectly valid Hyperfoil resource with everything set to default values. You can customize some properties in the `spec` section further - see the [reference](#reference).

The operator deploys only the controller; each agent is then started when the run starts as a `pod` in the same namespace and stopped when the run completes.

When the resource becomes ready (you can check it out through Openshift CLI using `oc get hf`) the controller pod should be up and running. Now you can open Hyperfoil CLI and connect to the controller. While default Hyperfoil port is 8090, default route setting uses TLS (edge) and therefore Openshift router will expose the service on port 443. If your cluster's certificate is not recognized (such as when using self-signed certificates) you need to use `--insecure` (or `-k`) option.

<pre class="nohighlight hljs"><code>
&gt; bin/cli.sh
[hyperfoil]$ connect hyperfoil-hyperfoil.apps.my.cluster.domain:443 --insecure
<span class="warnlog">WARNING: Hyperfoil TLS certificate validity is not checked. Your credentials might get compromised.</span>
Connected!
<span class="warnlog">WARNING: Server time seems to be off by 12124 ms</span>
</code></pre>

Now you can upload & run benchmarks as usual - we're using {% include example_link.md src='k8s-hello-world.hf.yaml' %} in this example. Note that it can take several seconds to spin up containers with agents.

<pre class="nohighlight hljs"><code>
[hyperfoil@hyperfoil-hyperfoil]$ upload examples/k8s-hello-world.hf.yaml
Loaded benchmark k8s-hello-world, uploading...
... done.
[hyperfoil@hyperfoil-hyperfoil]$ run k8s-hello-world
Started run 0000
Run 0000, benchmark k8s-hello-world
Agents: agent-one[STARTING]
Started: 2019/11/18 19:07:36.752    Terminated: 2019/11/18 19:07:41.778
<span class="hfcaption">NAME  STATUS      STARTED       REMAINING  COMPLETED     TOTAL DURATION               DESCRIPTION</span>
main  TERMINATED  19:07:36.753             19:07:41.778  5025 ms (exceeded by 25 ms)  5.00 users per second
[hyperfoil@hyperfoil-hyperfoil]$
</code></pre>

You can find more details about adjusting the agents in the [benchmark format reference]({{ "/docs/benchmark.html#kubernetesopenshift-deployer" | absolute_url }}).

Running Hyperfoil inside the cluster you are trying to test might skew results due to different network topology compared to driving the load from 'outside' (as real users would do). It is your responsibility to validate if your setup and separation between load driver and SUT (system under test) is correct. You have been warned.

## Reference

| Property                   | Description        |
| -------------------------- | ------------------ |
| version                    | Tag for controller image (e.g. `0.14` for a released version or `0.15-SNAPSHOT` for last build from main (master) branch). Defaults to `latest`. |
| image                      | Controller image. If 'version' is defined, too, the tag is replaced (or appended). Defaults to 'quay.io/hyperfoil/hyperfoil' |
| [route](#route)            | Configuration for the route leading to Controller REST endpoint. |
| [auth](#auth)              | Authorization configuration. |
| log                        | Name of the config map and optionally its entry (separated by '/': e.g myconfigmap/log4j2-superverbose.xml) storing Log4j2 configuration file. By default the Controller uses its embedded configuration. |
| agentDeployTimeout         | Deploy timeout for agents, in milliseconds. |
| triggerUrl                 | Value for `io.hyperfoil.trigger.url` - [see above](#starting-the-controller-manually)
| preHooks                   | List of config map names holding hooks that run before the run starts. |
| postHooks                  | List of config map names holding hooks that run when the run finishes. |
| persistentVolumeClaim      | Name of the PVC Hyperfoil should mount for its workdir. |

### route

| Property | Description |
| ---------| ----------- |
| host     | Host for the route leading to Controller REST endpoint. Example: hyperfoil.apps.cloud.example.com |
| type     | Either 'http' (for plain-text routes - not recommended), 'edge', 'reencrypt' or 'passthrough' |
| tls      | Name of the secret hosting `tls.crt`, `tls.key` and optionally `ca.crt`. This is mandatory for `passthrough` routes and optional for edge and reencrypt routes |

### auth

| Property | Description |
| -------- | ----------- |
| secret   | Name of secret used for basic authentication. Must contain key `password`; Hyperfoil accepts any username for login. |
