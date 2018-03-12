if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	$directory = Get-Location
	$parameters = "-NoExit -command cd " + $directory + "; .\" + $MyInvocation.MyCommand.Name
	Start-Process powershell.exe -Verb runAs $parameters
	exit
	break
} else {
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

	foreach($line in Get-Content .\packages-list.txt) {
		choco install $line --yes
	}
	
	Get-AppxPackage *3dbuilder* | Remove-AppxPackage
	Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
	Get-AppxPackage *officehub* | Remove-AppxPackage
	Get-AppxPackage *skypeapp* | Remove-AppxPackage
	Get-AppxPackage *getstarted* | Remove-AppxPackage
	Get-AppxPackage *zunemusic* | Remove-AppxPackage
	Get-AppxPackage *windowsmaps* | Remove-AppxPackage
	Get-AppxPackage *solitairecollection* | Remove-AppxPackage
	Get-AppxPackage *bingfinance* | Remove-AppxPackage
	Get-AppxPackage *zunevideo* | Remove-AppxPackage
	Get-AppxPackage *bingnews* | Remove-AppxPackage
	Get-AppxPackage *onenote* | Remove-AppxPackage
	Get-AppxPackage *people* | Remove-AppxPackage
	Get-AppxPackage *windowsphone* | Remove-AppxPackage
	Get-AppxPackage *windowsstore* | Remove-AppxPackage
	Get-AppxPackage *bingsports* | Remove-AppxPackage
	Get-AppxPackage *bingweather* | Remove-AppxPackage
	Get-AppxPackage *xboxapp* | Remove-AppxPackage
	
	$directory = Get-Location
	$parameters = "-NoExit -command cd " + $directory + "; .\post-installation-script.ps1"
	Start-Process powershell.exe -Verb runAs $parameters
}
