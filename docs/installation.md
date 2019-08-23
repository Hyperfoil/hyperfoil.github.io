# Installation

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

| Property                      | Default           | Description                           |
| ------------------------------|-------------------|---------------------------------------|
| io.hyperfoil.controller.host  | localhost         | Host for Controller REST server       |
| io.hyperfoil.controller.port  |              8090 | Port for Controller REST server       |
| io.hyperfoil.rootdir          | /tmp/hyperfoil    | Root directory for stored files       |
| io.hyperfoil.benchmarkdir     | *root*/benchmark  | Benchmark files (YAML and serialized) |
| io.hyperfoil.rundir           | *root*/run        | Run result files (configs, stats...)  |
| io.hyperfoil.deployer         | ssh               | Implementation for agents deployment  |
| io.hyperfoil.deployer.timeout | 15000 ms          | Timeout for agents to start           |

## Starting the controller via Ansible

You can fetch release, distribute and start the cluster using Ansible Galaxy scripts; [setup](https://github.com/Hyperfoil/hyperfoil_setup), [test](https://github.com/Hyperfoil/hyperfoil_test), [shutdown](https://github.com/Hyperfoil/hyperfoil_shutdown)

First, get the scripts:
```
ansible-galaxy install hyperfoil.hyperfoil_setup
ansible-galaxy install hyperfoil.hyperfoil_shutdown
ansible-galaxy install hyperfoil.hyperfoil_test
```

Now, edit your `hosts` file, it could look like this:
```
[hyperfoil-controller]
controller ansible_hostname=localhost

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


{% include docs_links.md %}