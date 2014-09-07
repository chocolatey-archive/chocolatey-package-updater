try { 

  $toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 
  $installFromDir = Join-Path $toolsDir 'chocopkgup' 
  ### For BinRoot, use the following ###
  $binRoot = "$env:systemdrive\tools"
  # Using an environment variable to to define the bin root until we implement configuration 
  if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
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