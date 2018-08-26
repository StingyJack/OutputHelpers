function Write-CurrentErrorStack 
{
    [CmdletBinding()]
    Param()

    if ($Error.Count -gt 1)
    {
        for($i = $Error.Count - 1; $i -ge 0; $i--)
        {
            $e = $Error[$i]
            $eText = $e | Format-List | Out-String
            Write-Host "Error[$i]:`n$eText`n" -ForegroundColor Red
        }
    }

}