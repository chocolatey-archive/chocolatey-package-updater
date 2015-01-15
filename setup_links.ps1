$chocopkgupSource = 'c:\codelocal\chocopkgup'

&git config --global core.symlinks false
New-Item ChocolateyPackageUpdaterSetup -Type Directory -Force
New-Item ChocolateyPackageUpdaterSetup\tools -Type Directory -Force
New-Item ChocolateyPackageUpdaterSetup\tools\chocopkgup -Type Directory -Force
pushd ChocolateyPackageUpdaterSetup
&cmd /c mklink /h ChocolateyPackageUpdater.nuspec $chocopkgupSource\nuget\ChocolateyPackageUpdater.nuspec
cd tools
&cmd /c mklink /h chocolateyInstall.ps1 $chocopkgupSource\nuget\tools\chocolateyInstall.ps1
cd chocopkgup
&cmd /c mklink /h chocopkgup.exe.ignore $chocopkgupSource\nuget\tools\chocopkgup\chocopkgup.exe.ignore
&cmd /c mklink /h ketarinupdate.cmd $chocopkgupSource\nuget\tools\chocopkgup\ketarinupdate.cmd
&cmd /c mklink /h chocopkgup.exe.config $chocopkgupSource\src\chocolateypackageupdater.console\app.config
&cmd /c mklink /h license.xml $chocopkgupSource\src\chocolateypackageupdater.console\license.xml
&cmd /c mklink /h License.txt $chocopkgupSource\docs\LEGAL\License.txt
popd

Write-Output "Once you are happy with this, delete the ChocolateyPackageUpdater folder and rename ChocolateyPackageUpdaterSetup to ChocolateyPackageUpdater."
