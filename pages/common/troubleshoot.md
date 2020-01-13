---
title: Troubleshooting
hide_sidebar: true
permalink: troubleshoot.html
folder: common
---

## My phase fails with SLA failure 'Progress was blocked waiting for a free connection. Hint: increase http.sharedConnections.'

By default Hyperfoil uses single connection to each HTTP(s) host; the default is set so low to force you thinking about connection limits early during test development. If you don't override this value as in:

```
http:
  host: http://hyperfoil.io
  sharedConnections: 1000
```

you get the error above, as the default SLA does not allow a session (virtual user) to be blocked due to not being able to acquire a connection from the connection pool immediatelly. If you can't increase number of connections (or use HTTP2 that allows multiple requests to multiplex within single connection), you can set

```
- httpRequest:
    sla:
    - blockedRatio: 1000 # any value big enough
```

on each request to drop the default SLA. The `blockedRatio` value is a threshold ratio between time spent waiting for a free connection and waiting for the response.

## When I set 'Host' header for HTTP request I get warnings

Hyperfoil automatically inserts the 'Host' header to each request and when you try to override that for certain request it emits a warning:

```
Setting `host` header explicitly is not recommended. Use the HTTP host and adjust actual target using `addresses` property.
```

With this warning on we don't inject the header as it *might* be intended, e.g. when the target server does not parse headers in a case-sensitive way (as it should!) and you have to use certain case. However, if you want to run your requests to a different IP than the host resolves to (e.g. hit `127.0.0.1:8080` with `Host: example.com`) you should rather use

```
http:
  host: http://hyperfoil.io
  addresses:
  - 127.0.0.1:8080
```
