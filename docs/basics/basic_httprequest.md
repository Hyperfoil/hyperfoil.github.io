# Steps

Steps are similar to statements in programming language.  An exhaustive list of steps can be found in the [scenario]({{ "/docs/steps/index.html" | absolute_url }}).

Example: 

```yaml
- thinkTime:
    duration: 3s
```

```yaml
- set: isOneWay <- false
```

```yaml
- httpRequest: ...
```


# HTTP Request

A common step is called httpRequest and method property (GET, POST, PUT, DELETE etc) is mandatory. Other properties are optional.  For example, headers and body are other properties.  httpRequest API can be found in the [httpRequest reference]({{ "/docs/steps/step_httpRequest.html" | absolute_url }}).


```yaml
- httpRequest:
    METHOD: URL_PATH
    HTTPREQUEST_PROPERTIES
```

Example:

```yaml
- httpRequest:
    headers:
      Content-Type: "application/x-www-form-urlencoded"
    POST: /flight/queryflights
    body:
      form:
      - name: airport
        value: OHR
```

# HTTP Response Handler

Optionally, response handler can be added.  Handler manages processing of HTTP responses.  It can process returned body, header, etc.  For more information, please refere to the [handler references]({{ "/docs/steps/step_httprequest.html#handler" | absolute_url }}).

```yaml
- httpRequest:
    handler:
      HANDLER_PROPERTIES
```

Example:

```yaml
- httpRequest:
    GET:
      value: /flight/queryflights
    handler:
      status:
        range: 2xx
```