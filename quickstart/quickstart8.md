---
---
# Getting started: Custom steps and handlers

Hyperfoil offers some basic steps to do HTTP requests, generate data, alter control flow in the scenario etc., but your needs may surpass the features implemented so far. Also, it might be just easier to express your logic in Java code than combining steps in the YAML. The downside is reduced ability to reuse and more tight dependency on Hyperfoil APIs.

This quickstart will show you how to extend Hyperfoil with custom steps and handlers. As we use the standard Java `ServiceLoader` approach, after you build the module you should drop it into `extensions` directory. (Note: if you upload the benchmarks through CLI you need to put it to both the machine where you run the CLI and to the controller.)

Each extension will consist of two classes:
* `Builder`, is loaded as service and creates the immutable extension instance
* extension (`Step`, `Action` or handler)

Let's start with a `io.hyperfoil.api.config.Step` implementation. The interface has single method `invoke(Session)` that should return `true` if the step was executed and `false` if its execution has been blocked and should be retried later. In case that the execution is blocked the invocation must not have any side effects - e.g. if the step is fetching objects from some pools and one of the pools is depleted, it should release the already acquired objects back to the pool.

We'll create a step that will divide variable from a session by a (configurable) constant and store the result in another variable.

{% include codesample.html src='distribution/src/main/java/io/hyperfoil/example/DivideStep.java' slice='21:50' %}

Then we need a builder class that will allow us to configure the step. To keep related classes together we will define it as inner static class:

{% include codesample.html src='distribution/src/main/java/io/hyperfoil/example/DivideStep.java' slice='51:116' %}

As the comments say, the builder is using fluent setter syntax to set the attributes. When you want to nest attributes under another builder, you can just add parameter-less method `FooBuilder foo()` the returns an instance of `FooBuilder`; the parser will fill this instance as well. There are some interfaces your builder can implement to accept lists or different structures, but the description is out of scope of this quickstart.

The builder class has two annotations: `@Name` which specifies the name we'll use in YAML as step name, and `@MetaInfServices` with `StepBuilder.class` as the parameter. If you were to implement other type of extension, this would be `Action.Builder.class`, `Request.ProcessorBuilder.class` etc. In order to record the service in META-INF directory in the jar you must also add this dependency to your module:

```xml
<dependency>
    <groupId>org.kohsuke.metainf-services</groupId>
    <artifactId>metainf-services</artifactId>
    <optional>true</optional>
</dependency>
```

The whole class {% include ghlink.md text='can be inspected here' src='distribution/src/main/java/io/hyperfoil/example/DivideStep.java' %} and it is already included in the `extensions` directory. You can try running `bin/standalone.sh`, upload and run {% include example_link.md src='divide.hf.yaml' %}. You should see about 5 log messages in the server log.

{% include codesample.html src='distribution/src/main/resources/examples/divide.hf.yaml' %}

There are several other integration points but `Step`:
* `io.hyperfoil.api.session.Action` is very similar to step, but it does not allow blocking. Implement `Action.BuilderFactory` to define new actions.
* `StatusHandler`, `HeaderHandler` and `BodyHandler` in `io.hyperfoil.api.http` package process different stages of HTTP response parsing. All these have `BuilderFactory` inner interface for you to implement.
* `io.hyperfoil.api.connection.Processor` performs later generic stages of response processing. As this interface is generic, there are two factories that you could use: `i.h.a.c.Request.ProcessorBuilderFactory` and `i.h.a.c.HttpRequest.ProcessorBuilderFactory`.

There is quite some boilerplate code in the process of creating a new component; that's why you can use Hyperfoil Codegen Maven plugin to scaffold the basic outline for you. Go to the module where you want the component generated and run:

```shell
mvn io.hyperfoil:hyperfoil-codegen-maven-plugin:skeleton
```

The plugin will ask you for the package name, component name and type and write down the source code skeleton. You can provide the parameters right on commandline like

```shell
mvn io.hyperfoil:hyperfoil-codegen-maven-plugin:skeleton \
    -Dskeleton.package=foo.bar -Dskeleton.name=myComponent -Dskeleton.type=step
```

Note: the generator does not add the dependency to `org.kohsuke.metainf-services:metainf-services` to this module's `pom.xml`, you need to do that manually.

If you add `io.hyperfoil` as a plugin group to your `$HOME/.m2/settings.xml` like this:

```xml
<settings>
  <pluginGroups>
    <pluginGroup>io.hyperfoil</pluginGroup>
  </pluginGroups>
  ...
</settings>
```

you can use the short syntax for the generator:

```shell
mvn hyperfoil-codegen:skeleton -Dskeleton.name=....
```

See also further information about [custom extensions development]({{ "/docs/extensions.html" | absolute_url }}).

---

This is the last quickstart in this series; if you seek more info check out the [documentation]({{ "/docs/" | absolute_url }}) or talk to us on [GitHub Discussions](https://github.com/Hyperfoil/Hyperfoil/discussions).
