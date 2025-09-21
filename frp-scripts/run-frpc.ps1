Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
trap {
    Write-Output "ERROR: $_"
    Write-Output (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Exit 1
}

# set password when requested.
if ($true) {
    Write-Output "Setting the runneradmin user password..."
    Get-LocalUser runneradmin `
        | Set-LocalUser `
            -Password (
                ConvertTo-SecureString `
                    -AsPlainText `
                    -Force `
                    Acbc_123456
            )
}

Write-Output 'Running frpc...'
./frp/frpc -c ./frp-scripts/frpc-windows.ini 2>&1 ; cmd /c exit 0
# Start-Process powershell -ArgumentList "-NoProfile -WindowStyle Hidden -Command `"& './frp/frpc' -c './frp-scripts/frpc-windows.ini' 2>&1; exit 0`"" -RedirectStandardOutput output.log
