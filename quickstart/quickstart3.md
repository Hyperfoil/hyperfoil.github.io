---
---
# Getting started: Complex workflow

The [previous example]({{ "/quickstart/quickstart2.html" | absolute_url }}) was the first 'real' benchmark, but it didn't do anything different from what you could run through `wrk`, `ab`, `siege` or similar tools.

Of course, the results were not suffering from the [coordinated omission problem]({{ "/docs/coordinated_omission.html/" | absolute_url }}), but Hyperfoil can do more. Let's try a more complex scenario, {% include example_link.md src='choose-movie.hf.yaml' %}:

{% include codesample.html src='distribution/src/main/resources/examples/choose-movie.hf.yaml' %}

Start the server and fire the scenario the usual way:

```shell
> docker run -v $(pwd)/examples/choose-movie.server:/config:z -p 8080:8083 jordimartin/mmock
> bin/cli.sh
```
<pre class="nohighlight hljs"><code>
[hyperfoil]$ start-local
...
[hyperfoil@in-vm]$ upload examples/choose-movie.hf.yaml
...
[hyperfoil@in-vm]$ run
...
</code></pre>

Is this scenario too simplistic? Let's [define phases]({{ "/quickstart/quickstart4.html" | absolute_url }})...
