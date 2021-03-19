---
---
# setInt

Set session variable to an integral value.

| Inline definition |
| -------- |
| Use <code>var &lt;- value</code>. |


| Property | Type | Description |
| ------- | ------- | -------- |
| intCondition | [Builder](#intcondition) | Set variable only if the current value satisfies certain condition. |
| onlyIfNotSet | boolean | Set variable to the value only if it is not already set. |
| value | int | Value (integer). |
| var | String | Variable name. |

### <a id="intCondition"></a>intCondition

| Property | Type | Description |
| ------- | ------- | ------- |
| equalTo | int | Compared variable must be equal to this value. |
| greaterOrEqualTo | int | Compared variable must be greater or equal to this value. |
| greaterThan | int | Compared variable must be greater than this value. |
| lessOrEqualTo | int | Compared variable must be lower or equal to this value. |
| lessThan | int | Compared variable must be lower than this value. |
| notEqualTo | int | Compared variable must not be equal to this value. |

