Describe Part1 {
    It 'Finds Rolls that can be removed' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 13
    }

    It 'Finds Rolls that can be removed' {
        & "$PSScriptRoot\part2.ps1" .\example.txt | Should -Be 43
    }
}