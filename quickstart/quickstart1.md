---
redirect_from:
- /quickstart/
---

# Getting started: First benchmark

1. Download [latest release](https://github.com/Hyperfoil/Hyperfoil/releases/latest) and unpack it
```
> wget {{ site.last_release.url }}
    && unzip {{ site.last_release.zip }}
    && cd {{ site.last_release.dir }}
```

2. Start Hyperfoil in interactive mode (CLI)
```
> bin/cli.sh
```

3. Run the minimalistic benchmark, doing only single request to `http://hyperfoil.io`:
```
[hyperfoil@localhost]$ run-local examples/single-request.hf.yaml
Running benchmark 'single-request'
Using 1 thread(s)
Target servers: http://hyperfoil.io:80/ (1 connections)
1 requests in 0.24s
                 Avg    Stdev      Max
Latency:      229.11 ms      0 ns 229.64 ms
Requests/sec: 4.166666666666667
```
Doing one request is not much of a benchmark and the statistics above are moot, but hey, this is a quickstart.

Now that you know how to run a benchmark, let's take a deeper look into [examples/single-request.hf.yaml]({{ site.github.repository_url }}/blob/master/distribution/src/main/resources/examples/single-request.hf.yaml).

{% raw %}
<script src="https://gist-it.appspot.com/github/Hyperfoil/Hyperfoil//blob/master/distribution/src/main/resources/examples/single-request.hf.yaml?footer=no"></script>
{% endraw %}

In the future you might find [editing with schema]({{ "/docs/editor.html" | absolute_url }}) useful but at this point any editor with YAML syntax highlighting will do the job.

Ready? Let's continue with [something a bit more realistic]({{ "/quickstart/quickstart2.html" | absolute_url }})...

{% include quickstart_links.md %}