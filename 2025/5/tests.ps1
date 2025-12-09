Describe 'Solution' {
    It 'Part 1' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 3
    }

    It 'Part 2' {
        
    } -Skip
}