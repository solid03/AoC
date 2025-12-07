param (
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $Banks = Get-Content -Path $Path

[int64[]] $Joltages = foreach ($Bank in $Banks) {
    $Stack = [System.Collections.Generic.Stack[char]]::new(12)

    for ($i = 0; $i -lt $Bank.Length; $i++) {
        $Remaining = $Bank.Length - $i

        while ($Stack.Count -and $Bank[$i] -gt $Stack.Peek() -and $Stack.Count + $Remaining -gt 12) {
            [void] $Stack.Pop()
        }

        if ($Stack.Count -lt 12) { $Stack.Push($Bank[$i]) }
    }

    $Return = while ($Stack.Count) { $Stack.Pop() }
    [array]::Reverse($Return)
    [int64]::Parse((-join $Return))
}

[System.Linq.Enumerable]::Sum($Joltages)