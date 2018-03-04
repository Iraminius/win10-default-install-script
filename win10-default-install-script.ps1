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
	
	$directory = Get-Location
	$parameters = "-NoExit -command cd " + $directory + "; .\post-installation-script.ps1"
	Start-Process powershell.exe -Verb runAs $parameters
}