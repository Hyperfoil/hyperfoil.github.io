# Scenario

Here is the basic scenario structure.  There is only one Scenario for one phase.  Each scenario consists of sequences.  When many sequences are specified in below syntax, they are executed sequentially.  If parallel execution are required, please see [initialSequences and sequences]({{ "/userguide/benchmark/scenario.html" | absolute_url }}).  For more detail, please see [scenario]({{ "/docs/concepts.html#scenario" | absolute_url }})

Note: httpRequest is a **step**, it will be the same level as all the other STEPS.

```yaml
scenario:
- SEQUENCE_NAME:
  (Optional - STEPS)
  - httpRequest: ...
```

Example: 

```yaml
scenario:
- queryFlight:
  - clearHttpCache:
  - set: isOneWay <- false
  - httpRequest: ...
```

## Sequences of Scenario
At least one of STEPS include httpRequest

```yaml
scenario:
- SEQUENCE_NAME:
    STEPS
- SEQUENCE_NAME:
    STEPS
- SEQUENCE_NAME:
    STEPS
```

Example: 

```yaml
scenario:
- queryFlight:
  - randomItem:
      file: AirportsFrom.txt
      toVar: fromCode
- bookFlight:
  - httpRequest: ...
- listBooking:
  - awaitAllResponses
  - httpRequest: ...
```

Next step is to create the [Steps]({{ "/docs/basics/basic_httprequest.html" | absolute_url }})
