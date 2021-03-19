---
---
# pullSharedMap

Move values from a map shared across all sessions using the same executor into session variables. 

 The executor can host multiple shared maps, each holding an entry with several variables. This step moves variables from either a random entry (if no <code>match</code> is set) or with an entry that has the same value for given variable as the current session. When data is moved to the current session the entry is dropped from the shared map.

| Property | Type | Description |
| ------- | ------- | -------- |
| key | String | Key identifying the shared map. |
| match | String | Name of the session variable that stores value identifying the entry in the shared map. |

