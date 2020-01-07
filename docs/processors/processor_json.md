# json

Parses JSON responses using simple queries. 

| Inline definition |
| -------- |
| Either <code>query -&gt; variable</code> or <code>variable &lt;- query</code>. |


| Property | Description |
| ------- | -------- |
| [processor](index.html#processors) | Pass the selected parts to another processor.  |
| query | Query selecting the part of JSON.  |
| toArray | Shortcut to store selected parts in an array in the session. Must follow the pattern <code>variable[maxSize]</code>  |

