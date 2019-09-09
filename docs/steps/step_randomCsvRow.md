# randomCsvRow

Stores random row from a CSV-formatted file to variables. 

| Property | Description |
| ------- | -------- |
| [columns](#columns) | Defines mapping from columns to session variables.  |
| file | Path to the CSV file that should be loaded.  |
| removeQuotes | Automatically unquote the columns.  |
| skipComments | Skip lines starting with character '#'.  |

### <a id="columns"></a>columns

| Property | Description |
| ------- | -------- |
| &lt;any&gt; | Use 0-based column as the key and variable name as the value.  |

