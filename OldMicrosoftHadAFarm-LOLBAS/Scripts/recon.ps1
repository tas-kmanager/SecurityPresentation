# Basic OS
systeminfo
wmic qfe
# Environemnt variables
Get-ChildItem Env: | ft Key,Value
# Connected drives
net use
wmic logicaldisk get caption,description,providername
Get-PSDrive | where {$_.Provider -like "Microsoft.PowerShell.Core\FileSystem"}| ft Name,Root
# Curent Username
whoami
# Current user privileges
whoami /priv
# Users on sysem
net users
dir /b /ad "C:\Users\"
Get-LocalUser | ft Name,Enabled,LastLogon
Get-ChildItem C:\Users\$username -Force | select Name
# Logged in users
qwinsta
# Local groups
net localgroup
Get-LocalGroup | ft Name
# Local Administrators
net localgroup Administrators
Get-LocalGroupMember Administrators | ft Name, PrincipalSource
# Registry for User Autologon
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon" 2>nul | findstr "DefaultUserName DefaultDomainName DefaultPassword"
Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon' | select "Default*"
# Scheduled tasks
schtasks /query /fo LIST 2>nul | findstr TaskName
dir C:\windows\tasks
Get-ScheduledTask | where {$_.TaskPath -notlike "\Microsoft*"} | ft TaskName,TaskPath,State
# Startup programs
wmic startup get caption,command
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
dir "C:\Documents and Settings\All Users\Start Menu\Programs\Startup"
Get-CimInstance Win32_StartupCommand | select Name, command, Location, User | fl
# NICs
ipconfig /all
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
Get-DnsClientServerAddress -AddressFamily IPv4 | ft
# Routes
route print
Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex
# ARP Cache
arp -a
Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State
# Active Connections
netstat -ano
# Hosts File
get-content C:\WINDOWS\System32\drivers\etc\hosts
# Network Interface configuration
netsh dump
# Get cached credentials
cmdkey /list
