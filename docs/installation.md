# Installation
{:.no_toc}

* replace me with table of contents
{:toc}

## Building from sources

```
mvn clean package -DskipTests=true
```
will do the trick as usual. You'll find the distribution in `distribution/target/distribution`.

## Required libraries

While all Java dependencies are packaged, in order to implement SSL with ALPN Netty (or its `tcnative-boringssl` component) requires `openssl` and `apr` libraries installed. If you are running Fedora 30 or later you need `libxcrypt-compat`, too.

## Starting the controller manually

Controller is started with
```
bin/controller.sh
```
Any arguments passed to the scripts will be passed as-is to the `java` process.

When you don't intend to run distributed benchmarks you can start the controller in standalone mode:
```
bin/standalone.sh
```
This variant won't deploy any agents remotely and therefore it does not need any `agents: ` section in the [benchmark definition]({{ "/docs/benchmark.html" | absolute_url }}); instead it will use single agent started in the same JVM.

Here is the comprehensive list of all the properties Hyperfoil recognizes:

| Property                             | Default            | Description                           |
| -------------------------------------|--------------------|---------------------------------------|
| io.hyperfoil.controller.host         | localhost          | Host for Controller REST server       |
| io.hyperfoil.controller.port         |              8090  | Port for Controller REST server       |
| io.hyperfoil.rootdir                 | /tmp/hyperfoil     | Root directory for stored files       |
| io.hyperfoil.benchmarkdir            | *root*/benchmark   | Benchmark files (YAML and serialized) |
| io.hyperfoil.rundir                  | *root*/run         | Run result files (configs, stats...)  |
| io.hyperfoil.deployer                | ssh                | Implementation for agents deployment  |
| io.hyperfoil.deployer.timeout        | 15000 ms           | Timeout for agents to start           |
| io.hyperfoil.agent.debug.port        |                    | If set, agent will be started with JVM debug port open |
| io.hyperfoil.agent.debug.suspend     | n                  | Suspend parameter for the debug port  |
| io.hyperfoil.controller.cluster.ip   | first non-loopback | Hostname/IP used for clustering with agents |
| io.hyperfoil.controller.cluster.port |               7800 | Default JGroups clustering port       |
| io.hyperfoil.controller.external.uri |                    | Externally advertised URI of REST server |
| io.hyperfoil.trigger.url             |                    | See below                             |

If `io.hyperfoi.trigger.url` is set the controller does not start benchmark run right away after hitting `/benchmark/my-benchmark/start` ; instead it responds with status 301 and header Location set to concatenation of this string and `BENCHMARK=my-benchmark&RUN_ID=xxxx`. CLI interprets that response as a request to hit CI instance on this URL, assuming that CI will trigger a new job that will eventually call `/benchmark/my-benchmark/start?runId=xxxx` with header `x-trigger-job`. This is useful if the the CI has to synchronize Hyperfoil to other benchmarks that don't use this controller instance.

## Starting the controller via Ansible

You can fetch release, distribute and start the cluster using Ansible Galaxy scripts; [setup](https://github.com/Hyperfoil/hyperfoil_setup), [test](https://github.com/Hyperfoil/hyperfoil_test), [shutdown](https://github.com/Hyperfoil/hyperfoil_shutdown)

First, get the scripts:
```
ansible-galaxy install hyperfoil.hyperfoil_setup,{{ site.last_release.galaxy_version }}
ansible-galaxy install hyperfoil.hyperfoil_shutdown,{{ site.last_release.galaxy_version }}
ansible-galaxy install hyperfoil.hyperfoil_test,{{ site.last_release.galaxy_version }}
```

Now, edit your `hosts` file, it could look like this:
```
[hyperfoil-controller]
controller ansible_host=localhost

[hyperfoil-agent]
agent-1 ansible_host=localhost
```
(You can add more agents by duplicating the last line with `agent-2` etc.)

Prepare your playbook; here is a short example that starts the controller, uploads and starts [simple benchmark](https://github.com/Hyperfoil/hyperfoil_test/blob/master/benchmarks/example.yaml.j2) (the templating engine replaces the agents in benchmark script based on Ansible hosts) and waits for its completion. When it confirms number of requests executed it stops the controller.

{% raw %}
```yaml
- hosts: [ hyperfoil-agent, hyperfoil-controller ]
  tasks: [] # This will only gather facts about all nodes
- hosts: hyperfoil-controller
  roles:
  - hyperfoil.hyperfoil_setup
- hosts: 127.0.0.1
  connection: local
  roles:
  - hyperfoil.hyperfoil_test
  vars:
    test_name: example
# Note that due to the way Ansible lookups work this will work only if hyperfoil-controller == localhost
- hosts: 127.0.0.1
  connection: local
  tasks:
  - name: Find number of requests
    set_fact:
      test_requests: "{{ lookup('csvfile', 'example file=/tmp/hyperfoil/workspace/run/' + test_runid + '/stats/total.csv col=2 delimiter=,')}}"
  - name: Print number of requests
    debug:
      msg: "Executed {{ test_requests }} requests."
- hosts:
  - hyperfoil-controller
  roles:
  - hyperfoil.hyperfoil_shutdown
```
{% endraw %}

Finally, run the playbook:
```
ansible-playbook -i hosts example.yml
```

## Deploying in Kubernetes/Openshift

A convenient alternative to running Hyperfoil on hosts with SSH access is deploying it in Kubernetes or Openshift. The recommended way to install it using an operator in your Openshift console - just go to Operators - OperatorHub and search for 'hyperfoil', and follow the installation wizard. Alternatively you can [deploy the controller manually]({{ "/docs/k8s_manual.html" | absolute_url }})

In order to start a Hyperfoil Controller instance in your cluster, create a new namespace `hyperfoil`: Go to Operators - Installed Operators and open Hyperfoil. In upper left corner select 'Project: ' - Create project and fill out the details. Then click on the 'Hyperfoil' tab and find the button 'Create Hyperfoil'.

You should see a YAML definition like this:

```yaml
apiVersion: hyperfoil.io/v1alpha1
kind: Hyperfoil
metadata:
  name: example-hyperfoil
  namespace: hyperfoil
spec:
  agentDeployTimeout: 60000
  log: myConfigMap/log4j2-superverbose.xml
  route: hyperfoil.apps.mycloud.example.com
  version: latest
```

Change the `name` to just `hyperfoil` (or whatever you prefer) and delete all the content from the `spec` section:

```yaml
apiVersion: hyperfoil.io/v1alpha1
kind: Hyperfoil
metadata:
  name: hyperfoil
  namespace: hyperfoil
spec:
```

This is a perfectly valid Hyperfoil resource with everything set to default values. You can customize some properties in the `spec` section further:

| Property                   | Description        |
| -------------------------- | ------------------ |
| version                    | Tag for controller image. Defaults to version matching the operator version (operator 0.5.x will default to 0.5 ) |
| image                      | Controller image. If 'version' is defined, too, the tag is replaced (or appended). Defaults to 'quay.io/hyperfoil/hyperfoil' |
| route                      | Host for the route leading to Controller REST endpoint. |
| log                        | Name of the config map and optionally its entry (separated by '/': e.g myconfigmap/log4j2-superverbose.xml) storing Log4j2 configuration file. By default the Controller uses its embedded configuration. |
| agentDeployTimeout         | Deploy timeout for agents, in milliseconds. |
| triggerUrl                 | Value for `io.hyperfoil.trigger.url` - [see above](#starting-the-controller-manually)
| preHooks                   | Name of config map holding hooks that run before the run starts. |
| postHooks                  | Name of config map holding hooks that run when the run finishes. |
| persistentVolumeClaim      | Name of the PVC Hyperfoil should mount for its workdir. |


The operator deploys only the controller; each agent is then started when the run starts as a `pod` in the same namespace and stopped when the run completes.

When the resource becomes ready (you can check it out through Openshift CLI using `oc get hf`) the controller pod should be up and running. Now you can open Hyperfoil CLI and connect to the controller. While default Hyperfoil port is 8090, Openshift router will expose the service on port 80.

```
> bin/cli.sh
[hyperfoil]$ connect hyperfoil-hyperfoil.apps.my.cluster.domain -p 80
Connected!
WARNING: Server time seems to be off by 12124 ms
```

Now you can upload & run benchmarks as usual - we're using {% include example_link.md src='k8s-hello-world.hf.yaml' %} in this example. Note that it can take several seconds to spin up containers with agents.

```
[hyperfoil@hyperfoil-hyperfoil]$ upload examples/k8s-hello-world.hf.yaml
Loaded benchmark k8s-hello-world, uploading...
... done.
[hyperfoil@hyperfoil-hyperfoil]$ run k8s-hello-world
Started run 0000
Run 0000, benchmark k8s-hello-world
Agents: agent-one[STARTING]
Started: 2019/11/18 19:07:36.752    Terminated: 2019/11/18 19:07:41.778
NAME  STATUS      STARTED       REMAINING  COMPLETED     TOTAL DURATION               DESCRIPTION
main  TERMINATED  19:07:36.753             19:07:41.778  5025 ms (exceeded by 25 ms)  5.00 users per second
[hyperfoil@hyperfoil-hyperfoil]$
```

You can find more details about adjusting the agents in the [benchmark format reference]({{ "/docs/benchmark.html#kubernetesopenshift-deployer" | absolute_url }}).

Running Hyperfoil inside the cluster you are trying to test might skew results due to different network topology compared to driving the load from 'outside' (as real users would do). It is your responsibility to validate if your setup and separation between load driver and SUT (system under test) is correct. You have been warned.

## Hooks

It might be useful to run certain scripts before and after the run, e.g. starting some infrastructure, preloading database, gathering CPU stats during the test and so on. That's why Hyperfoil introduces pre- and post-hooks to the run.

Some scripts are not specific to the test being run - these should be deployed on controller as files in `*root*/hooks/pre/` and `*root*/hooks/post` directories where *root* is controller's root directory, `/tmp/hyperfoil/` by default. Each of these directories should contain executable scripts or binaries that will be run in alphabetic order. We strongly suggest using the format `00-my-script.sh` to set the order using first two digits.

Kubernetes/Openshift deployments use the same strategy; the only difference is that the `pre` and `post` directories are mapped as volumes from a ConfigMap resource.

Other scripts may be specific to the benchmark executed and therefore you can define them directly in the YAML files. You can either use inline command that will be executed using `sh -c your-command --your-options` or create a Java class implementing `io.hyperfoil.core.hooks.RunHook` and register it to be [loaded as other Hyperfoil extensions]({{ "/quickstart/quickstart8.html" | absolute_url }}).

{% raw %}
```yaml
name: my-benchmark
pre:
  01-inline: curl http://example.com
  02-custom:
    my-hook:
      foo: bar
post:
  99-some-final-hook: ...
...
```
{% endraw %}

The lists of hooks from controller directories and benchmark are merged; if there's a conflict between two hooks from these two sources the final execution order is not defined (but both get executed).

In case of inline command execution the `stderr` output will stay on stderr, `stdout` will be caputered by Hyperfoil and stored in `*rundir*/*XXXX*/hooks.json`. As the post-hooks are executed after `info.json` and `all.json` get written the output cannot be included inside those files. This order of execution was chosen because it's likely that you will upload these files to a database - yes, using a post-hook.

{% include docs_links.md %}