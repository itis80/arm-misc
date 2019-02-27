  #Azure prequisities
  #Mikko Itämäki 2018

  
   $ErrorActionPreference = "stop"
  
  ## Download & install Azure virtual machines agent

    


   $vmAgentInstallationPath = "C:\temp\VmInstallerPath"

    New-Item -ItemType Directory -Force -Path $vmAgentInstallationPath | Out-Null
    cd $vmAgentInstallationPath
    Write-Host "   > Download path: $vmAgentInstallationPath"
    (New-Object system.net.WebClient).DownloadFile("https://azurevmtools.blob.core.windows.net/media/WindowsAzureVmAgent.2.7.1198.788.rd_art_stable.161208-0959.fre.msi", "$vmAgentInstallationPath\VMAgent.msi");
    Write-Host "   > Download success."
    Write-Host "   > Installing..."
    Start-Process -FilePath "VMAgent.msi" -ArgumentList "/quiet /l* vmagent-installation.log" -Wait

    Write-Host "   > Installation complete. The installation logs can be found in the download path."


  ## Remove winhttp proxy

  Write-Host "   >Remove winhttp proxy"

  netsh winhttp reset proxy

  Write-Host "   >Done."

  ## Set SAN policy to onlineall

  Write-Host "   >Set SAN policy to OnlineAll"

  Set-StorageSetting -NewDiskPolicy OnlineAll 
  

 Write-Host "   >Done."

  ## Set timezone to automatic

  Write-Host "   >Set timezone to automatic"

  REG ADD HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1

  Set-Service -Name W32Time -StartupType Automatic

  Write-Host "   >Done."
  
  ## Set services to default values

  Write-Host "   >Set Windows services to default values"

  $ServicesAuto = "bfe","dcomlaunch","dhcp","dnscache","IKEEXT","iphlpsvc","LSM","NlaSvc","nsi","RpcSs","RpcEptMapper","MpsSvc","LanmanWorkstation","RemoteRegistry"
  $ServicesDemand = "PolicyAgent","netlogon","netman","NcaSvc","netprofm","termService","WinHttpAutoProxySvc"

  foreach ($ServiceAuto in $ServicesAuto)

          {

            Set-Service -Name $ServiceAuto -StartupType Automatic
            
         }



  foreach ($ServiceDemand in $ServicesDemand)

        {

          Set-Service -Name $ServiceDemand -StartupType Manual

        }
 

 Write-Host "   >Done."


## RDP configuration

Write-Host "   >Set RDP Configuration"

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD  /d 1 /f

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD  /d 1 /f

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v fAllowSecProtocolNegotiation /t REG_DWORD  /d 1 /f

Write-Host "   >Done."

## Enable PS Remoting 

Enable-PSRemoting -force

## Configure Windows Firewall rules
##  Inbound

netsh advfirewall firewall set rule dir=in name="File and Printer Sharing (Echo Request - ICMPv4-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (LLMNR-UDP-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (NB-Datagram-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (NB-Name-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (Pub-WSD-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (SSDP-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (UPnP-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Network Discovery (WSD EventsSecure-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Windows Remote Management (HTTP-In)" new enable=yes

netsh advfirewall firewall set rule dir=in name="Windows Remote Management (HTTP-In)" new enable=yes

##  Inbound and Outbound

netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes

netsh advfirewall firewall set rule group="Core Networking" new enable=yes

##  Outbound

netsh advfirewall firewall set rule dir=out name="Network Discovery (LLMNR-UDP-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (NB-Datagram-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (NB-Name-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (Pub-WSD-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (SSDP-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (UPnPHost-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (UPnP-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (WSD Events-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (WSD EventsSecure-Out)" new enable=yes

netsh advfirewall firewall set rule dir=out name="Network Discovery (WSD-Out)" new enable=yes

## Set BCD Settings

bcdedit /set {bootmgr} integrityservices enable

bcdedit /set {default} device partition=C:

bcdedit /set {default} integrityservices enable

bcdedit /set {default} recoveryenabled Off

bcdedit /set {default} osdevice partition=C:

bcdedit /set {default} bootstatuspolicy IgnoreAllFailures



