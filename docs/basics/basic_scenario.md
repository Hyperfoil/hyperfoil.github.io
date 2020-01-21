# Scenario

Here is the basic scenario structure.  Scenario can be one or many.  When many scenarios are specified, they will be executed sequentially.  For more detail, please see [scenario]({{ "/docs/concepts.html#scenario" | absolute_url }})

Note: httpRequest is a **step**, it will be the same level as all the other STEPS.

```yaml
scenario:
- SCENARIO_NAME:
  (Optional - STEPS)
  - httpRequest: ...
```

Example: 

```yaml
scenario:
- queryFlight:
  - thinkTime:
      duration: 3s
  - set: isOneWay <- false
  - httpRequest: ...
```

## Sequences of Scenario

```yaml
scenario:
- SCENARIO_NAME:
  - httpRequest: ...
- SCENARIO_NAME:
  - httpRequest: ...
- SCENARIO_NAME:
  - httpRequest: ...
```

Example: 

```yaml
scenario:
- queryFlight:
  - httpRequest: ...
- bookFlight:
  - httpRequest: ...
- listBooking:
  - httpRequest: ...
```

Next step is to create the [Steps]({{ "/docs/basics/basic_httprequest.html" | absolute_url }})
