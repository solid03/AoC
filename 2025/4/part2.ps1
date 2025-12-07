param(
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt",
    [switch] $Visualize
)

[string[]] $RawMap = Get-Content -Path $Path

## Pad raw map
[system.Collections.Generic.List[char[]]] $Map = "." * ($RawMap[0].Length + 2)
$RawMap.ForEach{ $Map.Add(".${_}.") }
$Map.Add($Map[0])

## Solve
do {
    $Removed = 0
    for ($Row = 1; $Row -lt $Map.Count - 1; $Row++) {
        for ($Column = 1; $Column -lt $Map[0].Length - 1; $Column++) {
            if ($Map[$Row][$Column] -ne '@') { continue }

            $Neighbors = -join (-join $Map[$Row - 1][($Column - 1)..($Column + 1)], ## North
                -join $Map[$Row][($Column - 1), ($Column + 1)],                     ## East, West
                -join $Map[$Row + 1][($Column - 1)..($Column + 1)])                 ## South

            if (($Neighbors -replace '\.').Length -lt 4) {
                $Map[$Row][$Column] = '.'
                $Removed++
            }
        }
    }
    $Return += $Removed
} while ($Removed -ne 0)

if ($Visualize) { $Map.GetEnumerator().ForEach{ -join $_ } } else { $Return }
