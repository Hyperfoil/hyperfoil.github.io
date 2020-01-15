---
title: Hyperfoil
sidebar: 06_sidebar
permalink: index.html
toc: false
---

<h2 id="project_description">{{ site.description }}</h2>

&nbsp;
&nbsp;

<div class="container">
<div class="row">
  <div class="col-md-2">
  <figure>
    <img src="images/hierarchy_organization.png" alt="Distributed"  style="width:80%">
    <h2>Distributed</h2>
    <figcaption>Drive the load from many nodes.</figcaption>
    </figure>
  </div>
   <div class="col-md-2">
  <figure>
    <img src="images/graph_arrow_spike.png" alt="Accurate"  style="width:90%">
    <h2>Accurate</h2>
    <figcaption>All operations are async to avoid the <a href="https://www.azul.com/files/HowNotToMeasureLatency_LLSummit_NYC_12Nov2013.pdf">coordinated-omission fallacy</a></figcaption>
    </figure>
  </div>
  <div class="col-md-2">
  <figure>
    <img src="images/puzzle_complete.png" alt="Versatile"  style="width:80%">
    <h2>Versatile</h2>
    <figcaption>You can express complex scenarios either in YAML or through pluggable steps.</figcaption>
    </figure>
  </div>
  <div class="col-md-2">
  <figure>
    <img src="images/recycle_symbol.png" alt="Low-Allocation"  style="width:80%">
    <h2>Low-Allocation</h2>
    <figcaption>Internally we try to allocate as little as possible on the critical code paths to not let garbage-collector disturb the operations.</figcaption>
    </figure>
  </div>
</div>
</div>


&nbsp;
&nbsp;


Hyperfoil is licensed under [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)

