# Basic Knowledge

## Benchmark Structure

In order to successfully create a benchmark, keep in mind the following basic benchmark structure in YAML file.

```
Global Configuration
Phases
  Scenarios
    Steps
    HTTP Request (Note: httpRequest is a mandatory Step)
      HTTP Response Handler
        Response Processor
        Actions
```