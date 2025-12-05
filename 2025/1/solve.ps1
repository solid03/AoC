[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
[CmdletBinding()]
param(
    [switch] $Part2
)

function Measure_DialTouchZero {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Move
    )

    begin {
        [int] $Dial = 50
        [int] $Return = 0
    }
    process {
        try {
            ## test input
            if (-not ($Move -match '^(?<Direction>[L|R])(?<Distance>\d+)$')) {
                throw "Unable to parse move: '$Move'"
            }

            if ($Matches.Direction -eq 'R') {
                if ($Part2) {
                    $Return += [math]::Truncate(($Dial + $Matches.Distance) / 100)
                }
                $Dial = ($Dial + $Matches.Distance) % 100
            } else {
                $temp = $Dial - ($Matches.Distance % 100)

                if ($Part2) {
                    $base = (100 - $Dial) % 100
                    $Return += [math]::Truncate(($base + $Matches.Distance) / 100)
                }

                $Dial = $temp -ge 0 ? $temp : $temp + 100
            }

            ## test result
            if (-not ($Dial -ge 0 -and $Dial -le 99) ) {
                throw "Dial out of bounds: $Dial ; $Move"
            }

            if ($Dial -eq 0 -and -not $Part2) { $Return++ }
        } catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
    end { Write-Output $Return }
}

Get-Content -Path "$PSScriptRoot\input.txt" |
    Measure_DialTouchZero
