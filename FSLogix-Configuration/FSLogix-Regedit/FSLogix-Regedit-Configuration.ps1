##############
# Variables #
##############
$StorageAccountName = ""
$AzureFileShareName = ""
$FslogixDirectoryIDName = ""
$RedirectionDirectoryIDName = ""
$AzureFileFSLogixConnectionString = "\\$StorageAccountName.file.core.windows.net\$AzureFileShareName\$FslogixDirectoryIDName" 
$AzureFileFSLogixRedirectionconnectionString = "\\$storageAccountName.file.core.windows.net\$AzureFileShareName\$RedirectionDirectoryIDName"

#################
# Permission   #
#################
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

#####################################
# FSLogix Regedit Configuration    #
#####################################
Push-Location 
Set-Location HKLM:\SOFTWARE\
New-Item `
    -Path HKLM:\SOFTWARE\FSLogix `
    -Name Profiles `
    -Value "" `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "Enabled" `
    -Type "Dword" `
    -Value "1" `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "VHDLocations" `
    -Value $AzureFileFSLogixConnectionString `
    -PropertyType MultiString `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "SizeInMBs" `
    -Type "Dword" `
    -Value "40000"`
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "IsDynamic" `
    -Type "Dword" `
    -Value "1"`
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "VolumeType" `
    -Type String `
    -Value "vhdx"`
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "ConcurrentUserSessions" `
    -Type "Dword" `
    -Value "1"`
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "FlipFlopProfileDirectoryName" `
    -Type "Dword" `
    -Value "1" `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "SIDDirNamePattern" `
    -Type String `
    -Value "%username%%sid%"`
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "SIDDirNameMatch" `
    -Type String `
    -Value "%username%%sid%" `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "ProfileType" `
    -Type "Dword" `
    -Value "0" `
    -Force
New-ItemProperty `
    -Path HKLM:\Software\FSLogix\Profiles `
    -Name "KeepLocalDir" `
    -Type "Dword" `
    -Value "0" `
    -Force
New-ItemProperty `
    -Path HKLM:\SOFTWARE\FSLogix\Profiles `
    -Name "DeleteLocalProfileWhenVHDShouldApply" `
    -PropertyType "DWord" `
    -Value "1" `
    -Force
New-ItemProperty `
    -Path HKLM:\SOFTWARE\FSLogix\Profiles `
    -Name "RedirXMLSourceFolder" `
    -Value $AzureFileFSLogixRedirectionconnectionString `
    -PropertyType MultiString `
    -Force
    New-ItemProperty `
    -Path HKLM:\SOFTWARE\FSLogix\Profiles `
    -Name "RoamRecycleBin" `
    -Value "0" `
    -PropertyType "DWord" `
    -Force
    New-ItemProperty `
    -Path HKLM:\SOFTWARE\FSLogix\Profiles `
    -Name "RoamIdentity" `
    -Value "1" `
    -PropertyType "DWord" `
    -Force  
Pop-Location
