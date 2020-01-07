---
layout: navigation
---

# Basics

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
```

## Definition Tables
This documentation contains auto-generated definition tables that explain each yaml key & value formats.  This is how these tables should be used


### <a id="EXAMPLE"></a>EXAMPLE

Example description. 

| Property | Description |
| ------- | -------- |
| Key | Explanation for the valye  |

YAML syntax
```
EXAMPLE:
  Key: Value
```

e.g.

### <a id="POST"></a>POST

Generic builder for generating a string. 

| Property | Description |
| ------- | -------- |
| fromVar | Load the string from session variable.  |
| pattern | Use pattern replacing session variables.  |
| value | String value used verbatim.  |

YAML syntax
```
POST:
  value: /flight/queryflights
```

&nbsp;

Some definition has inline definition as follows

### set

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

YAML syntax
```
set: myVar <- "This is my value"
```
&nbsp;

There is also [Schema Support]({{ "/docs/editor.html" | absolute_url }}) in Visual Studio Code to automatically check the yaml syntax.

