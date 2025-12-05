Describe Part1 {
    It 'Finds highest joltage' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 357
    }
}

Describe Part2 {
    It 'Finds highest joltage for 12' {
        & "$PSScriptRoot\part2.ps1" .\example.txt | Should -Be 3121910778619
    }
}