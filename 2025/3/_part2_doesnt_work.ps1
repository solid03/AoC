param (
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $Banks = Get-Content -Path $Path

[int64[]] $HighestJoltage = foreach ($Bank in $Banks) {
    # Reverse array with stack
    [System.Collections.Generic.Stack[char]] $Chars = $Bank.ToCharArray()
    
    # Initialize with first 2 digits
    [char[]] $Return = [char[]]::new(2)
    (1..2) | ForEach-Object { $Return[ - $_] = $Chars.Pop() }
    [char] $Current = [char]'0'

    while ($Chars.TryPop([ref] $Current)) {
        [string[]] $foo = @(
            (-join $Return),                                       # Current value
            ((-join $Return) -replace '^.', $Current),             # Replace first digit
            ((-join $Return) -replace '^', $Current -replace '.$') # Shift right
        )
        $Return = $foo | Sort-Object | Select-Object -last 1
    }

    -join $Return
}

($HighestJoltage | Measure-Object -Sum).Sum
