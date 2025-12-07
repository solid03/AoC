param(
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $RawMap = Get-Content -Path $Path

## Pad raw map
[system.Collections.Generic.List[char[]]] $Map = "." * ($RawMap[0].Length + 2)
$RawMap.ForEach{ $Map.Add(".${_}.") }
$Map.Add($Map[0])

## Solve
for ($Row = 1; $Row -lt $Map.Count - 1; $Row++) {
    for ($Column = 1; $Column -lt $Map[0].Length - 1; $Column++) {
        if ($Map[$Row][$Column] -ne '@') { continue }

        $Neighbors = -join (-join $Map[$Row - 1][($Column - 1)..($Column + 1)], ## North
            -join $Map[$Row][($Column - 1), ($Column + 1)],                     ## East, West
            -join $Map[$Row + 1][($Column - 1)..($Column + 1)])                 ## South

        if (($Neighbors -replace '\.').Length -lt 4) {
            $Return++
        }
    }
}

$Return