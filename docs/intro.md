---
redirect_from:
- /docs
- /docs/
---
# Introduction to Hyperfoil

There's plenty of web benchmark tools around and it might be hard to pick one, and investing time into not-established tools is risky. Hyperfoil was not created for the pure joy of coding but as a solution to set of problems which could not be solved all by single other existing tool.

## Free software

Free software allows you to take your benchmark and publish it for everyone to verify. With proprietary licenses that wouldn't be so easy.

Hyperfoil is licensed under [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Distribution

Generating load with single node stops scaling at certain point and you need to orchestrate the benchmark across a cluster of nodes. Simple command-line tools usually ignore this completely (you're supposed to start them, gather and merge the data in a bash scripts). Other tools use open-core model with the clustering part being a paid/proprietary option. There are frameworks that have clustering built in as well.

Hyperfoil uses master-slave model with Vert.x Event bus as the clustering middleware. While running from single VM is possible (and [quite easy]({{ "/quickstart/quickstart1.html" | absolute_url }})) as well, the design is distributed by default.

## Accuracy

The point of web benchmark is usually finding out what happens when your system is accessed by thousands of concurrent users - each doing a page load every few seconds. However many traditional load drivers simplify the scenario to few dozen of virtual users (VUs) that execute one request after another or with very short delays in between - this is referred to as the Closed System Model (as the set of VUs is finite). This discrepancy leads to problem known as [coordinated omission](https://www.azul.com/files/HowNotToMeasureLatency_LLSummit_NYC_12Nov2013.pdf) and results in significantly skewed latency results and pathological conditions (queues overflow...) not being triggered.

Hyperfoil embraces Open System Model by default - virtual users are completely independent until it runs out of resources, recording that situation in consequence. Hyperfoil runs a state-machine for each VU and all requests are executed asynchronously.

## Versatility

While you can design your benchmark to just hit single endpoint (URL) with desired rate this is likely not what the users would be doing. Randomizing some parts of the query or looping through a list of endpoint might be better but the resulting scenario might be still too simplified.

Hyperfoil introduces a DSL expressed in YAML with which you can sketch the scenario in a fine detail, including timing, concurrent requests, processing responses and so forth. We're not trying to invent a new programming language, though, so if the DSL gets too complex you can [write the logic]({{ "/quickstart/quickstart8.md" | absolute_url }}) in Java or any other JVM language.

***

If you're eager to try out Hyperfoil go to the [Getting started tutorial]({{ "/quickstart/quickstart1.html" | absolute_url }}). Otherwise let's have a deeper look into the [terms and concepts]({{ "/docs/concepts.html" | absolute_url }}).
