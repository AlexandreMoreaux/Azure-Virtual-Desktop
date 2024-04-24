#Add Fslogix to the GPO of the DC

#First Connect to the Domain Controller VM.

#####################
# Fslogix Variable #
#####################
$folderpathfslogix = "C:\Fslogix" 
$FslogixSource = "https://aka.ms/fslogix_download" #THIS VARIABLE NOT NEED TO BE MODIFIED
$FslogixZipOutputfile = "$folderpathfslogix\FSLogix_Apps.zip" #THIS VARIABLE NOT NEED TO BE MODIFIED

###############################################
# Adding Fslogix to the AD GPO possibilities #
###############################################

#Create a temporary folder
if (-not (Test-Path $folderpathfslogix)) {
  New-Item -ItemType Directory -Path $folderpathfslogix
  Write-Host "Folder created: $folderpathfslogix"
} else {
  Write-Host "Folder already exists: $folderpathfslogix"
}

#Download and Expand Fslogix
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Invoke-WebRequest -Uri $FslogixSource -OutFile $FslogixZipOutputfile
Expand-Archive $FslogixZipOutputfile -DestinationPath $folderpathfslogix

#Move the ADML file to the folder
Copy-Item -Path "$folderpathfslogix\fslogix.admx" -Destination "C:\Windows\PolicyDefinitions\"
#Move the ADMX file to the folder
Copy-Item -Path "$folderpathfslogix\fslogix.adml" -Destination "C:\Windows\PolicyDefinitions\en-US\"

##############################
# Delete the temporary file #
##############################
Remove-Item -Path $folderPath -Recurse
Remove-Item -Path $folderpathfslogix -Recurse

