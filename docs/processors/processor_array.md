# array

Stores data in an array stored as session variable. 

| Inline definition |
| -------- |
| Use format <code>toVar[maxSize]</code>. |


| Property | Description |
| ------- | -------- |
| format | Format into which should this processor convert the buffers before storing. Default is <code>STRING</code>. <br>Options:{::nomarkdown}<ul><li><code>BYTEBUF</code>: {:/}Store the buffer directly. Beware that this may cause memory leaks! {::nomarkdown}</li><li><code>BYTES</code>: {:/}Store data as byte array. {::nomarkdown}</li><li><code>STRING</code>: {:/}Interprets the bytes as UTF-8 string. {::nomarkdown}</li></ul>{:/} |
| maxSize | Maximum size of the array.  |
| toVar | Variable name.  |

