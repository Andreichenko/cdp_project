Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1, *profile.ps1 |
        ForEach-Object {
            . $_.FullName
        }