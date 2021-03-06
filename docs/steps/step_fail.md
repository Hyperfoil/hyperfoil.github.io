---
---
# fail

Fail the phase with given message. Used mostly for testing/debugging.

| Property | Type | Description |
| ------- | ------- | -------- |
| allConditions | [Builder](#allconditions) | Condition combining multiple other conditions with 'AND' logic. |
| boolCondition | [Builder](#boolcondition) | Condition comparing boolean variables. |
| intCondition | [Builder](#intcondition) | Condition comparing integer variables. |
| message | String | Message attached to the failure exception. |
| stringCondition | [Builder](#stringcondition) | Condition comparing string variables. |

### <a id="allConditions"></a>allConditions

Test more conditions and combine the results using AND logic.

| Property | Type | Description |
| ------- | ------- | ------- |
| &lt;list of mappings&gt; | [&lt;list of builders&gt;](#allconditionslist-of-mappings) | List of conditions. |

### <a id="allConditions.&lt;list of mappings&gt;"></a>allConditions.&lt;list of mappings&gt;

Selector for condition type.

| Property | Type | Description |
| ------- | ------- | ------- |
| allConditions | [Builder](#allconditionslist-of-mappingsallconditions) | Condition combining multiple other conditions with 'AND' logic. |
| boolCondition | [Builder](#allconditionslist-of-mappingsboolcondition) | Condition comparing boolean variables. |
| intCondition | [Builder](#allconditionslist-of-mappingsintcondition) | Condition comparing integer variables. |
| stringCondition | [Builder](#allconditionslist-of-mappingsstringcondition) | Condition comparing string variables. |

### <a id="allConditions.&lt;list of mappings&gt;.allConditions"></a>allConditions.&lt;list of mappings&gt;.allConditions

Test more conditions and combine the results using AND logic.

| Property | Type | Description |
| ------- | ------- | ------- |
| &lt;list of mappings&gt; | [&lt;list of builders&gt;](#allconditionslist-of-mappings) | List of conditions. |

### <a id="allConditions.&lt;list of mappings&gt;.boolCondition"></a>allConditions.&lt;list of mappings&gt;.boolCondition

Tests session variable containing boolean value.

| Property | Type | Description |
| ------- | ------- | ------- |
| fromVar | String | Variable name. |
| value | boolean | Expected value. |

### <a id="allConditions.&lt;list of mappings&gt;.intCondition"></a>allConditions.&lt;list of mappings&gt;.intCondition

Condition comparing integer in session variable.

| Property | Type | Description |
| ------- | ------- | ------- |
| equalTo | int | Compared variable must be equal to this value. |
| fromVar | Object | Variable name. |
| greaterOrEqualTo | int | Compared variable must be greater or equal to this value. |
| greaterThan | int | Compared variable must be greater than this value. |
| isSet | boolean | Check if the value is set or unset. By default the variable must be set. |
| lessOrEqualTo | int | Compared variable must be lower or equal to this value. |
| lessThan | int | Compared variable must be lower than this value. |
| notEqualTo | int | Compared variable must not be equal to this value. |

### <a id="allConditions.&lt;list of mappings&gt;.stringCondition"></a>allConditions.&lt;list of mappings&gt;.stringCondition

Condition comparing string in session variable.

| Property | Type | Description |
| ------- | ------- | ------- |
| caseSensitive | boolean | True if the case must match, false if the check is case-insensitive. |
| endsWith | CharSequence | Suffix for the string. |
| equalTo | CharSequence | Literal value the string should match (the same as {@link #value}). |
| fromVar | Object | Variable name. |
| isSet | boolean | Check if the value is set or unset. By default the variable must be set. |
| length | int | Check the length of the string. |
| length (alternative)| [Builder](#stringconditionlength) | Check the length of the string. |
| matchVar | String | Fetch the value from a variable. |
| negate | boolean | Invert the logic of this condition. Defaults to false. |
| notEqualTo | CharSequence | Value that the string must not match. |
| startsWith | CharSequence | Prefix for the string. |
| value | CharSequence | Literal value the string should match. |

### <a id="boolCondition"></a>boolCondition

Tests session variable containing boolean value.

| Property | Type | Description |
| ------- | ------- | ------- |
| fromVar | String | Variable name. |
| value | boolean | Expected value. |

### <a id="intCondition"></a>intCondition

Condition comparing integer in session variable.

| Property | Type | Description |
| ------- | ------- | ------- |
| equalTo | int | Compared variable must be equal to this value. |
| fromVar | Object | Variable name. |
| greaterOrEqualTo | int | Compared variable must be greater or equal to this value. |
| greaterThan | int | Compared variable must be greater than this value. |
| isSet | boolean | Check if the value is set or unset. By default the variable must be set. |
| lessOrEqualTo | int | Compared variable must be lower or equal to this value. |
| lessThan | int | Compared variable must be lower than this value. |
| notEqualTo | int | Compared variable must not be equal to this value. |

### <a id="stringCondition"></a>stringCondition

Condition comparing string in session variable.

| Property | Type | Description |
| ------- | ------- | ------- |
| caseSensitive | boolean | True if the case must match, false if the check is case-insensitive. |
| endsWith | CharSequence | Suffix for the string. |
| equalTo | CharSequence | Literal value the string should match (the same as {@link #value}). |
| fromVar | Object | Variable name. |
| isSet | boolean | Check if the value is set or unset. By default the variable must be set. |
| length | int | Check the length of the string. |
| length (alternative)| [Builder](#stringconditionlength) | Check the length of the string. |
| matchVar | String | Fetch the value from a variable. |
| negate | boolean | Invert the logic of this condition. Defaults to false. |
| notEqualTo | CharSequence | Value that the string must not match. |
| startsWith | CharSequence | Prefix for the string. |
| value | CharSequence | Literal value the string should match. |

### <a id="stringCondition.length"></a>stringCondition.length

| Property | Type | Description |
| ------- | ------- | ------- |
| equalTo | int | Compared variable must be equal to this value. |
| greaterOrEqualTo | int | Compared variable must be greater or equal to this value. |
| greaterThan | int | Compared variable must be greater than this value. |
| lessOrEqualTo | int | Compared variable must be lower or equal to this value. |
| lessThan | int | Compared variable must be lower than this value. |
| notEqualTo | int | Compared variable must not be equal to this value. |

