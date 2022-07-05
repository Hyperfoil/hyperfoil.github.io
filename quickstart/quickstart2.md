---
---
# Getting started: Steps and statistics

In [previous quickstart]({{ "/quickstart/quickstart1.html" | absolute_url }}) you created a benchmark
that fires only one HTTP request. Our next example {% include example_link.md src='random-urls.hf.yaml' %} is going to hit random URLs at this server with 10 requests per second. We'll see how to generate random data and collect statistics for different URLs.

First start a mocking server:
```shell
> go get github.com/jmartin82/mmock
> mmock -server-ip localhost -server-port 8080 -config-path examples/random-urls.server
```
If you prefer running that as Docker container, use
```shell
> docker run -v $(pwd)/examples/random-urls.server:/config:z -p 8080:8083 jordimartin/mmock
```

Here is the benchmark we're going to run:

{% include codesample.html src='distribution/src/main/resources/examples/random-urls.hf.yaml' %}

So let's run this through CLI:
<pre class="nohighlight hljs"><code>
[hyperfoil]$ start-local
...
[hyperfoil@in-vm]$ upload examples/random-urls.hf.yaml
...
[hyperfoil@in-vm]$ run
Started run 0002
Run 0002, benchmark random-urls
Agents: in-vm[STARTING]
Started: 2019/11/15 17:49:45.859    Terminated: 2019/11/15 17:49:50.904
<span class="hfcaption">NAME  STATUS      STARTED       REMAINING  COMPLETED     TOTAL DURATION               DESCRIPTION</span>
main  TERMINATED  17:49:45.859             17:49:50.903  5044 ms (exceeded by 44 ms)  10.00 users per second
[hyperfoil@in-vm]$ stats
Total stats from run 0002
<span class="hfcaption">PHASE  METRIC  REQUESTS  MEAN       p50        p90        p99        p99.9      p99.99     2xx  3xx  4xx  5xx  CACHE  TIMEOUTS  ERRORS  BLOCKED</span>
main   images        34    3.25 ms    3.39 ms    4.39 ms   12.58 ms   12.58 ms   12.58 ms   12   13   12    0      0         0       0    1.11 ms
main   pages         13    2.89 ms    3.19 ms    4.15 ms    4.33 ms    4.33 ms    4.33 ms   13    0    0    0      0         0       0       0 ns

main/images: Progress was blocked waiting for a free connection. Hint: increase http.sharedConnections.
</code></pre>
There are several things worth mentioning in this example:
- The command `run` does not have any argument. In this case, the benchmark name `random-urls` is optional as you've just uploaded it and CLI knows that you are going to work with it. The same holds for `stats` - you don't have to write down run ID `0002` when displaying statistics as the implicit run ID is set automatically in the `run`/`status` command.
- The test did only 47 requests in 5 seconds, instead of 50. It does not execute one request every 100 ms sharp, it randomizes the times of requests as well; this simulates the [Poisson point process](https://en.wikipedia.org/wiki/Poisson_point_process). Longer runs would have lower variance in the total numbers.
- In metric `images` the test reports 1.11 ms being blocked and there's SLA failure below the stats. This is happening because in the default configuration Hyperfoil opens only one connection to the target server. All (possibly concurrent) requests have to share the common pool of 1 connection and if some request cannot be executed immediatelly we report this as blocked time. All practical benchmarks should increase the pool size to a value that reflects simulated load and prevent this situation.
- The test took 44 ms longer than the configured 5 seconds. We terminate the test only after all responses for sent requests arrive (or time out).

In the next quickstart you'll see a [more complex scenario]({{ "/quickstart/quickstart3.html" | absolute_url }})
