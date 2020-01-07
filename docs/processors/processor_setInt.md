# setInt

Set session variable to an integral value. 

| Inline definition |
| -------- |
| Use <code>var &lt;- value</code>. |


| Property | Description |
| ------- | -------- |
| [intCondition](#intCondition) | Set variable only if the current value satisfies certain condition.  |
| onlyIfNotSet | Set variable to the value only if it is not already set.  |
| value | Value (integer).  |
| var | Variable name.  |

### <a id="intCondition"></a>intCondition

| Property | Description |
| ------- | -------- |
| equalTo | Compared variable must be equal to this value.  |
| greaterOrEqualTo | Compared variable must be greater or equal to this value.  |
| greaterThan | Compared variable must be greater than this value.  |
| lessOrEqualTo | Compared variable must be lower or equal to this value.  |
| lessThan | Compared variable must be lower than this value.  |
| notEqualTo | Compared variable must not be equal to this value.  |

