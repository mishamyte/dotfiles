# WAU Mod: Discord.Discord-installed.ps1
# Runs after Discord upgrade/install has been confirmed.
# Disables Discord's "Open on Startup" setting and removes startup registry entries.

# --- Step 1: Kill Discord processes to prevent settings.json overwrite ---
Stop-ModsProc @("Discord")
Get-Process -Name "Update" -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -like "*\Discord\Update.exe" } |
    Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# --- Step 2: Fix settings.json ---
$settingsPath = "C:\Users\Myte\AppData\Roaming\discord\settings.json"
if (Test-Path $settingsPath) {
    try {
        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $json | Add-Member -NotePropertyName "OPEN_ON_STARTUP" -NotePropertyValue $false -Force
        $jsonString = $json | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($settingsPath, $jsonString, [System.Text.UTF8Encoding]::new($false))
        Write-ToLog "-> Discord OPEN_ON_STARTUP disabled in settings.json" "Green"
    }
    catch {
        Write-ToLog "-> Failed to update Discord settings.json - $_" "Red"
    }
}

# --- Step 3: Remove Discord from startup registry for all loaded user hives ---
$loadedSIDs = Get-ChildItem "Registry::HKEY_USERS" -ErrorAction SilentlyContinue |
    Where-Object { $_.PSChildName -match "^S-1-5-21-" -and $_.PSChildName -notmatch "_Classes$" }
foreach ($sid in $loadedSIDs) {
    $regPath = "Registry::HKEY_USERS\$($sid.PSChildName)\Software\Microsoft\Windows\CurrentVersion\Run"
    if (Test-Path $regPath) {
        $discordEntry = Get-ItemProperty -Path $regPath -Name "Discord" -ErrorAction SilentlyContinue
        if ($discordEntry) {
            Remove-ItemProperty -Path $regPath -Name "Discord" -ErrorAction SilentlyContinue
            Write-ToLog "-> Discord startup registry entry removed for SID: $($sid.PSChildName)" "Green"
        }
    }
}
