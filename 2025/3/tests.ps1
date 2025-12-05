Describe Part1 {
    It 'Finds highest joltage' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 357
    }
}