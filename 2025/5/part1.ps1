param (
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $DB = Get-Content -Path $Path
$Delimiter = $DB.IndexOf('')

## Build fresh list
[string[]] $Fresh = $DB[0..($Delimiter - 1)] | Sort-Object { ($_ -split '-')[0] }

## Find fresh ingredients
$Return = foreach ($Item in ($DB[($Delimiter + 1)..$DB.Length])) {
    [int64] $ID = $Item
    foreach ($Range in $Fresh) {
        [int64] $Start, [int64] $End = $Range -split '-'
        if ($Start -le $ID -and $ID -le $End) {
            $ID
            break
        }
    }
}

$Return.Count