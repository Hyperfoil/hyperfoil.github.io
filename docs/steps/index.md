# Hyperfoil reference



## Steps
* [addToInt](./step_addToInt.html): Add value to integer variable in the session. 
* [awaitAllResponses](./step_awaitAllResponses.html): Block current sequence until all requests receive the response. 
* [awaitDelay](./step_awaitDelay.html): Block this sequence until referenced delay point. 
* [awaitInt](./step_awaitInt.html): Block current sequence until condition becomes true. 
* [awaitVar](./step_awaitVar.html): Block current sequence until this variable gets set/unset. 
* [breakSequence](./step_breakSequence.html): Prematurely stops execution of this sequence if the condition is satisfied. 
* [clearHttpCache](./step_clearHttpCache.html): Drops all entries from HTTP cache in the session. 
* [foreach](./step_foreach.html): Instantiate new sequences based on array variable content. 
* [httpRequest](./step_httpRequest.html): Issues a HTTP request and registers handlers for the response. 
* [json](./step_json.html): Parse JSON in variable into another variable. 
* [log](./step_log.html): Log a message and variable values. 
* [loop](./step_loop.html): Repeats a sequence fixed-number times. 
* [nextSequence](./step_nextSequence.html): Schedules a new sequence instance to be executed. 
* [noop](./step_noop.html): Does nothing. Only for demonstration purposes. 
* [pullSharedMap](./step_pullSharedMap.html): Move values from a map shared across all sessions using the same executor into session variables. 
* [pushSharedMap](./step_pushSharedMap.html): Store values from session variables into a map shared across all sessions using the same executor into session variables. 
* [randomCsvRow](./step_randomCsvRow.html): Stores random row from a CSV-formatted file to variables. 
* [randomInt](./step_randomInt.html): Stores random (linearly distributed) integer into session variable. 
* [randomItem](./step_randomItem.html): Stores random item from a list or array into session variable. 
* [scheduleDelay](./step_scheduleDelay.html): Define a point in future until which we should wait. Does not cause waiting. 
* [set](./step_set.html): Set variable in session to certain value. 
* [setInt](./step_setInt.html): Set session variable to an integral value. 
* [stop](./step_stop.html): Immediately stop the user session (break all running sequences). 
* [stopwatch](./step_stopwatch.html): Run nested sequence of steps, recording execution time. 
* [stringToInt](./step_stringToInt.html)
* [template](./step_template.html): Format pattern into session variable. 
* [thinkTime](./step_thinkTime.html): Block current sequence for specified duration. 
* [unset](./step_unset.html): Undefine variable name. 


## Actions
* [addToInt](./action_addToInt.html): Add value to integer variable in the session. 
* [clearHttpCache](./action_clearHttpCache.html): Drops all entries from HTTP cache in the session. 
* [set](./action_set.html): Set variable in session to certain value. 
* [setInt](./action_setInt.html): Set session variable to an integral value. 
* [stringToInt](./action_stringToInt.html)
* [unset](./action_unset.html): Undefine variable name. 
