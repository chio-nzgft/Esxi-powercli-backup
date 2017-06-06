# Clone VM
# Script is base on http://communities.vmware.com/message/1506367, LucD’s reply.
# Added args for mulitple use by mark
# [ON LINE] PBX.SQL (Win2012 core)
# Eat Params
$fromVMname = '`[ON LINE`] PBX.SQL (Win2012 core)'
$newVMName =  '`[OFF LINE`] PBX.SQL (Win2012 core) -- BACKUP'
$tgtEsxName = "192.168.1.199"
$tgtDatastoreName = "datastore-2"

# Load Powershell snapin from VMware
# ignore all errors
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

# Connect ESX/vCenter Server
connect-viserver $vCenterName

# remove cloned VM
$VMR = get-vm $newVMName
Remove-vm -VM $VMR -DeleteFromDisk -confirm:($false)

$newVMName =  '[OFF LINE] PBX.SQL (Win2012 core) -- BACKUP'

$VMF = Get-VM $fromVMname

# Doing Clone
$cloneTask = New-VM -Name $newVMName -VM $VMF -VMHost (Get-VMHost $tgtEsxName) -Datastore (Get-Datastore $tgtDatastoreName) -RunAsync

#email back
Wait-Task -Task $cloneTask -ErrorAction SilentlyContinue
Get-Task | where {$_.Id -eq $cloneTask.Id} | %{
$EmailFrom = "chiotest@gmail.com"
$EmailTo = "chiotest@gmail.com" 
$Subject = "Esxi backup " + $fromVMname + " " + $_.State
$Body = "this is a notification from powershell.. " + $event
$SMTPServer = "smtp.gmail.com" 
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("chiotest", "password");
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
}

# powershell -command "& {c: clonevm.ps1 comp-name clone-comp-name esx-ip datastore v}"
