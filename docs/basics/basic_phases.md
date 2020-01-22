# Phases

These are different types of phases based on the mode of starting new users.  For more detail, please see [phases]({{ "/docs/concepts.html#phases" | absolute_url }})

## constantPerSec

* The benchmark will start certain number of users according to a schedule regardless of previously started users completing the scenario. This is the open-model.

```yaml
Phases:
- PHASE_NAME:
    constantPerSec:
      usersPerSec: USERES_PER_SECOND
      duration: DURATION
      scenario: ...
```

Example: 

```yaml
Phases:
- steadyState:
    constantPerSec:
      usersPerSec: 100
      duration: 5m
      scenario: ...
```

## rampPerSec

* Similar to `constantPerSec` but ramps up or down the number of started users throughout the execution of the phase.

```yaml
Phases:
- PHASE_NAME:
    rampPerSec:
      initialUsersPerSec: INITIAL_USERES_PER_SECOND
      targetUsersPerSec: TARGET_USERES_PER_SECOND
      duration: DURATION
      scenario: ...
```

Example: 

```yaml
Phases:
- rampUp:
    rampPerSec:
      initialUsersPerSec: 1
      targetUsersPerSec: 100
      duration: 5m
      scenario: ...
```

## atOnce

* All users are started when the phase starts running and once the scenario is completed the users won't retry the scenario.

```yaml
Phases:
- PHASE_NAME:
    atOnce:
      users: TOTAL_USERS
      duration: DURATION
      scenario: ...
```

Example: 

```yaml
Phases:
- final:
    atOnce:
      users: 100
      duration: 5m
      scenario: ...
```

## always

* There is fixed number of users. Each user will start executing the scenario independently & right after the scenario is completed, start repeating the same process.  Throughput varies depending on the number of users & response time.  This is called a closed-model and is similar to the way many benchmarks with fixed number of threads work.

```yaml
Phases:
- PHASE_NAME:
    always:
      users: TOTAL_USERS
      duration: DURATION
      scenario: ...
```

Example: 

```yaml
Phases:
- final:
    always:
      users: 100
      duration: 5m
      scenario: ...
```

## Sequential Execution

* To sequencially execute the phases, add `startAfter`


```yaml
Phases:
- PHASE_NAME:
    constantPerSec:
      usersPerSec: USERES_PER_SECOND
      duration: DURATION
      startAfter: PREVIOUS_PHASE
      scenario: ...
```

Example: 

```yaml

Phases:

- rampUp:
    rampPerSec:
      initialUsersPerSec: 1
      targetUsersPerSec: 100
      duration: 5m
      scenario: ...

- steadyState:
    constantPerSec:
      usersPerSec: 100
      duration: 5m
      startAfter: rampUp
      scenario: ...
```

## Sessions

The state of each user's scenario is saved in the session, it is necessary to know how many sessions should be preallocated.  Please see [sessions]({{ "/docs/concepts.html#sessions" | absolute_url }})

```yaml
Phases:
- PHASE_NAME:
    constantPerSec:
      usersPerSec: USERES_PER_SECOND
      duration: DURATION
      maxSessionsEstimate: MAX_SESSION
      scenario: ...
```

Example: 

```yaml
Phases:
- steadyState:
    constantPerSec:
      usersPerSec: 100
      duration: 5m
      maxSessionsEstimate: 200
      scenario: ...
```

Next step is to create the [scenario]({{ "/docs/basics/basic_scenario.html" | absolute_url }})

