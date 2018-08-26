function Write-DataTable
{
    [CmdletBinding()]
    Param(
        [System.Data.DataTable]$DataTable
    )

    $colNames = ""
    $colSep = ""
    $colMaxLengths = @{}
    foreach($col in $DataTable.Columns)
    {
        $maxColLength = 10
        foreach ($row in $DataTable.Rows)
        {
            $colValue = [System.Convert]::ToString($row[$col.ColumnName])
            if ($colValue.Length -gt $maxColLength)
            {
                $maxColLength = $colValue.Length
            }   
        }
        $maxColLength = [System.Math]::Max($maxColLength, $col.ColumnName.Length)
        $columnNameSpacing = [string]::new(" ", $maxColLength - $col.ColumnName.Length)

        $colNames += "$($col.ColumnName)$columnNameSpacing  "
        $headerSeparator = [string]::new("-",$maxColLength + 1)
        $colSep += "$headerSeparator "
        $colMaxLengths.Add($col.ColumnName, $maxColLength)
    }
   
    Write-Host "`t`t$colNames"
    Write-Host "`t`t$colSep"

    foreach($row in $DataTable.Rows)
    {
        Write-Host "`t`t" -NoNewline
        foreach ($col in $row.Table.Columns)
        {
            $colValue = [System.Convert]::ToString($row[$col.ColumnName])
            $spaceCount = $colMaxLengths[$col.ColumnName] - $colValue.Length + 1
            $colPaddingSpaces = [string]::new(" ", $spaceCount)
            Write-Host "$colValue$colPaddingSpaces " -NoNewline
        }
        Write-Host ""
    }
}