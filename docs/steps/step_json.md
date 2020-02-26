# json

Parse JSON in variable into another variable. 

| Property | Type | Description |
| ------- | ------- | -------- |
| format | enum | Conversion to apply on the matching parts. <br>Options:{::nomarkdown}<ul><li><code>BYTEBUF</code>: {:/}Store the buffer directly. Beware that this may cause memory leaks! {::nomarkdown}</li><li><code>BYTES</code>: {:/}Store data as byte array. {::nomarkdown}</li><li><code>STRING</code>: {:/}Interprets the bytes as UTF-8 string. {::nomarkdown}</li></ul>{:/} |
| fromVar | String | Variable to load JSON from.  |
| query | String | JSON query to apply.  |
| toVar | String | Variable to store the result. If there are multiple matches, the variable will be overwritten and last match wins.  |
