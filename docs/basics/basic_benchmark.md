# Basic Benchmark Structure


Every benchmark starts with this global configuration.

```yaml
name: BENCHMARK_NAME
http:
  host: URL
  sharedConnections: CONNECTIONS
phases: ...
```

* URL is the HTTP protocol and hostname of the Application Under Test (e.g. http://myapp.com)
* Shared connections are total number of physical HTTP connections.

Example: 

```yaml
name: My_App
http:
  host: http://myapp.com:9080
  sharedConnections: 10
phases: ...
```

## Multiple Core Support

* By default, Hyperfoil only utlizes single core for the execution for experimenting & debugging.  For production usage, add the `threads` that matches to the total CPU core numbers.

```yaml
name: BENCHMARK_NAME
threads: CPU_CORES
http:
  host: URL
  sharedConnections: CONNECTIONS
phases: ...
```

Example: 

```yaml
name: My_App
threads: 4
http:
  host: http://myapp.com:9080
  sharedConnections: 10
phases: ...
```

## Private HTTP Pools

* To keep connection private to the session until the session completes and prefer these connection, use `ergonomics` with `privateHttpPools` true. (Note: Session is the state of one virtual user.)

```yaml
name: BENCHMARK_NAME
threads: CPU_CORES
ergonomics:
  privateHttpPools: true
http:
  host: URL
  sharedConnections: CONNECTIONS
phases: ...
```

Example: 

```yaml
name: My_App
threads: 4
ergonomics:
  privateHttpPools: true
http:
  host: http://myapp.com:9080
  sharedConnections: 10
phases: ...
```

## DNS providing multiple IPs

* When DNS is providing multiple IPs to go through one or more proxies, use the `addresses` (e.g. service mesh such as ISTIO) 

```yaml
name: BENCHMARK_NAME
threads: CPU_CORES
http:
  host: URL
  addresses:
  - PROXY_IP:PROXY_PORT
  - ANOTHER_PROXY_IP
  sharedConnections: CONNECTIONS
phases: ...
```

Example: 

```yaml
name: My_App
threads: 4
http:
  host: http://myapp.com:9080
  addresses:
  - 123.456.789.101:8080
  - 123.456.789.102
  sharedConnections: 10
phases: ...

## Controller and agents

* To use distributed mode, start the [controller] ({{ "/docs/installation.html" | absolute_url }}), then add the `agents` in benchmark.
. Agents deployment types are [SSH]({{ "/docs/benchmark.html#ssh-deployer" | absolute_url }}) and [K8s]({{ "/docs/benchmark.html#kubernetesopenshift-deployer" | absolute_url }}) deployers.  Please see the detailed syntax in the link.

```yaml
name: BENCHMARK_NAME
threads: CPU_CORES
ergonomics:
  privateHttpPools: true
agents:
  AGENTS
http:
  host: URL
  sharedConnections: CONNECTIONS
phases: ...
```

SSH deployer Example: 

```yaml
name: My_App
threads: 4
ergonomics:
  privateHttpPools: true
agents:
  agent1: myagent_server:22
http:
  host: http://myapp.com:9080
  sharedConnections: 10
phases: ...
```

Next step is to create the [phases]({{ "/docs/basics/basic_phases.html" | absolute_url }})
