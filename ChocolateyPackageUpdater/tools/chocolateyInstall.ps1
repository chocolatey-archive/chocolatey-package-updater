$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 
$installDir = Join-Path $toolsDir 'chocopkgup' 
$installDirBackup = $installDir.Replace("\lib\","\lib-bkp\")

$binRoot = Get-BinRoot
$oldInstallDir = Join-Path $binRoot 'ChocolateyPackageUpdater'
$oldInstallDirBackup = Join-Path $binRoot 'ChocolateyPackageUpdater.backup'

if ([System.IO.Directory]::Exists($oldInstallDir)) {
  Copy-Item "$($oldInstallDir)\chocopkgup.exe.config" "$installDir" -Force -Recurse
  Copy-Item "$($oldInstallDir)\chocopkgup.exe.config" "$installDirBackup" -Force -Recurse
  if (![System.IO.Directory]::Exists($oldInstallDirBackup)) {[System.IO.Directory]::CreateDirectory($oldInstallDirBackup)}
  Copy-Item "$($oldInstallDir)\*" "$oldInstallDirBackup" -Force -Recurse -ErrorAction Continue
  Write-Warning "Inspect and delete '$oldInstallDirBackup' - new install location is with package"
  [System.IO.Directory]::Delete($oldInstallDir, $true)
}
