# Basic Knowledge

## Benchmark Structure

In order to successfully create a benchmark, keep in mind the following basic benchmark structure in YAML file.

```
Benchmark Definition
  Phases
    Scenarios
      Steps
      HTTP Request
          HTTP Response Handler
            Response Processor
            Actions
```

## Application Program Interface (API)
This documentation contains auto-generated APIs that explain each yaml key & value formats.  This is how these tables should be used

***
EXAMPLE

Example description. 

| Property | Description |
| ------- | -------- |
| Key | Explanation for the valye  |

***

YAML syntax
```
EXAMPLE:
  Key: Value
```

&nbsp;

For example, POST definition looks like this:

*** 

POST

Generic builder for generating a string. 

| Property | Description |
| ------- | -------- |
| fromVar | Load the string from session variable.  |
| pattern | Use pattern replacing session variables.  |
| value | String value used verbatim.  |

*** 

YAML syntax
```
POST:
  value: /flight/queryflights
```

&nbsp;

Some definition has inline definition like this:

***

SET

Set variable in session to certain value. 

| Inline definition |
| -------- |
| Use <code>var &lt;- value</code>. |


| Property | Description |
| ------- | -------- |
| [intArray](#intArray) | Set variable to an (unset) integer array.  |
| [objectArray](#objectArray) | Set variable to an (unset) object array.  |
| value | String value.  |
| var | Variable name.  |

***

YAML syntax
```
set: myVar <- "This is my value"
```
&nbsp;

There is also [Schema Support](editor.html) in Visual Studio Code to automatically check the yaml syntax.

First step is to create the [top level benchmark block]({{ "/docs/basics/basic_benchmark.html" | absolute_url }})

