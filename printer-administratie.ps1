if (!(Test-path -Path 'C:\temp\GEUPDPCL6Win_3500MU\driver\win_x64'))
{
#Create temp directory
New-Item -ErrorAction Ignore -Path 'c:\temp' -ItemType Directory

#Download driver from Develep
Invoke-WebRequest -Uri "https://dl.develop.eu/nl/?tx_kmanacondaimport_downloadproxy[fileId]=3339bd9227b7b56e5c7b3b4fbef0d16f&tx_kmanacondaimport_downloadproxy[documentId]=102800&tx_kmanacondaimport_downloadproxy[system]=Develop&tx_kmanacondaimport_downloadproxy[language]=NL&type=1558521685" -OutFile "C:\temp\GEUPDPCL6Win_3500MU.zip"

#Download 7zip
#Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z1900-x64.msi" -OutFile "C:\temp\7z1900-x64.msi"
#Start-Process msiexec.exe -Wait -ArgumentList '/I C:\temp\7z1900-x64.msi /quiet /norestart'

#Unzip file
cmd /c "C:\Progra~1\7-Zip\7z.exe x c:\temp\GEUPDPCL6Win_3500MU.zip -oc:\temp -r"

#Add printer driver
Invoke-Command {pnputil.exe -a "C:\temp\GEUPDPCL6Win_3500MU\driver\win_x64\KOBS8JA_.inf" }
Add-PrinterDriver -Name "Generic Universal PCL"
Start-Sleep 3
}

#Add printer port
$portName = "10.10.100.94"
$portExists = Get-Printerport -Name $portName -ErrorAction SilentlyContinue
if (-not $portExists) {
Add-PrinterPort -Name 10.10.100.94 -PrinterHostAddress "10.10.100.94"
Start-Sleep 3

#Add printer
Add-Printer -DriverName "Generic Universal PCL" -Name "Moerkapelle Administratie" -PortName "10.10.100.94"
}
