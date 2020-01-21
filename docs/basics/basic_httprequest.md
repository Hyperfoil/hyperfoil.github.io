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

One special step is called httpRequest.  httpRequest consists of method (GET, POST, PUT, DELETE etc) and properties.  Properties can be headers and body.  httpRequest API can be found in the [pttpRequest reference](0.6_steps_httpRequest.html).


```yaml
- httpRequest:
    METHOD:
      value: URL_PATH
    HTTPREQUEST_PROPERTIES
```

Example:

```yaml
- httpRequest:
    headers:
      Content-Type: "application/x-www-form-urlencoded"
    POST:
      value: /flight/queryflights
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
    POST:
      value: /flight/queryflights
    handler:
      body:
        json:
          query: .[] 
```