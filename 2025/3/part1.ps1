param (
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $Banks = Get-Content -Path $Path

[int[]] $HighestJoltages = foreach ($Bank in $Banks) {
    # Reverse string by adding to stack
    [System.Collections.Generic.Stack[char]] $Chars = $Bank.ToCharArray()

    # Initialize
    [char[]] $Return = [char[]]::new(2)
    $Return[1], $Return[0] = $Chars.Pop(), $Chars.Pop()
    [char] $Current = [char]'0'

    # Pop stack then find highest "number"
    while ($Chars.TryPop([ref] $Current)) {
        $Return = $Return, (-join $Current, $Return[0]), (-join $Current, $Return[1]) |
            Sort-Object |
            Select-Object -Last 1
    }

    -join $Return -as [int]
}

($HighestJoltages | Measure-Object -Sum).Sum
