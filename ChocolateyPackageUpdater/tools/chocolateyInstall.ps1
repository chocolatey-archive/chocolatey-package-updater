try { 

  $toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 
  $installFromDir = Join-Path $toolsDir 'chocopkgup' 

  $binRoot = Get-BinRoot
  $installDir = Join-Path $binRoot 'ChocolateyPackageUpdater'
  Write-Host "Adding `'$installDir`' to the path and the current shell path"
  Install-ChocolateyPath "$installDir"
  $env:Path = "$($env:Path);$installDir"
  
  if (![System.IO.Directory]::Exists($installDir)) {[System.IO.Directory]::CreateDirectory($installDir)}
  Copy-Item "$($installFromDir)\*" "$installDir" -Force -Recurse

  Write-ChocolateySuccess 'ChocolateyPackageUpdater'
} catch {
  Write-ChocolateyFailure 'ChocolateyPackageUpdater' "$($_.Exception.Message)"
  throw 
}