---
---

# Templates

It is often useful to keep a single benchmark in version control but change parts of it depending on the infrastructure where it is executed or intended load. Since [version 0.18]({{ "/docs/release_notes.html" | absolute_url }}) Hyperfoil supports parametrization of the benchmark through templates.

Inspired by other (more complex) YAML templating systems we decided to use YAML tags to pre-process the YAML. Templating happens even before applying the YAML nodes onto `BenchmarkBuilder`, therefore it is not possible to do that programmatically or with the serialized form.

If you are working with CLI or WebCLI there is little difference to regular benchmarks: you `upload` and `edit` the benchmark as usual. However it is not possible to auto-detect files before the benchmark is constructed from the template (the reference to a file could be a template, too!), therefore you need to pass all files using option `-f` to the `upload`/`edit` command.

When the benchmark template is uploaded, upon running it (`run mybenchmark`) you either pass the parameters using option `-P` or you are interactively asked to provide those params. The parameters are stored in CLI context and on subsequent invocations of `run` you don't need to set these. If you want to remove the parameters from the context use option `-r`/`--reset-params`. To see both default and current parameters you can use the `inspect` command.

# Param

You should use `!param` to replace single scalar value:

<pre class="langauge-yaml hljs"><code>
name: example
http:
  host: http://localhost:8080
usersPerSec: !param NUM_USERS <q id="users"></q>
duration: !param DURATION 60s <q id="duration"></q>
scenario: # ...
</code></pre>

In this simple constant-rate benchmark you can customize the number of users starting each second as well as the duration. There's no default for `NUM_USERS` <q data-ref="users"></q>; you will be asked to provide it when you run the benchmark. On the other hand `DURATION` <q data-ref="duration"></q> has a default value of `60s` - anything after the space after parameter name counts as the default value.

Parameters don't have to be upper-case. The identifier is case-sensitive, though.

<pre class="language-plaintext">
<code>$ run scalar-value-example -PNUM_USERS=5 -PDURATION=60s
</code></pre>

# Concat

Sometimes you need to replace only part of a string: `!concat` will let you do that:

<pre class="langauge-yaml hljs"><code>
name: example
http:
  host: !concat [ "http://", !param SERVER localhost, ":8080" ] <q id="server"></q>
usersPerSec: 10
duration: 60s
scenario: # ...
</code></pre>

In this example we will customize the host with the concatenation of `http://`, parameter `SERVER` with default `localhost` and `:8080`. This example uses inline-form of list, though you can use the regular list (one item per line), too.

# Foreach

Chances are you need to generate a list based on a param: you can do this using the `!foreach`:

<pre class="langauge-yaml hljs"><code>
name: example
http: !foreach
  items: http://example.com,http://hyperfoil.io <q id="items"></q>
  separator: ","<q id="separator"></q> # comma is the default separator
  param: ITEM<q id="param"></q>   # ITEM is the default parameter name
  do: <q id="do"></q>
    host: !param ITEM
usersPerSec: 10
duration: 60s
scenario: # ...
</code></pre>

This splits the item list <q data-ref="items"></q> using the separator regexp <q data-ref="separator"></q> and produces a list of values or mappings <q data-ref="do"></q> while the param <q data-ref="param"></q> is set to one of the values from items list. The example above would result in:

<pre class="langauge-yaml hljs"><code>
name: example
http:
- host: http://example.com
- host: http://hyperfoil.io
usersPerSec: 10
duration: 60s
scenario: # ...
</code></pre>

You can also set `items` to a YAML list; in that case the `separator` is not used:

```yaml
myList: !foreach
  items: ["A", !param B, "C"]
  param: FOO
  do: !param FOO
```

The last example with `-PB=bar` would result in:

<pre class="langauge-yaml hljs"><code>
myList:
- A
- bar
- C
</code></pre>

Renaming the param used for iteration can be useful in nested loops: without renaming the inner foreach would shadow the outer one.

# Anchors and aliases

YAML has a built-in concept for removing repetitive sections: anchors and aliases. With the templating system you can use that universally throughout the file (in versions before 0.18 the support was limited to forks, scenarios and sequences):

<pre class="langauge-yaml hljs"><code>
foo: &hello-world
  hello: world
anotherFoo:
  sayHi: *hello-world
  myList:
  - *hello-world
  - bar
</code></pre>

is interpretted as

<pre class="langauge-yaml hljs"><code>
foo:
  hello: world
anotherFoo:
  sayHi:
    hello: world
  myList:
  - hello: world
  - bar
</code></pre>
