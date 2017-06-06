# snap VM
# [ON LINE] EIP
# Eat Params
$doVMname = '`[ON LINE`] EIP'
$vCenterName = "192.168.0.200"
$filenameFormat = "EIP" + (get-date -Format "yyyy-MM-dd")
$delfilenameFormat = "EIP" + (get-date (get-date).addDays(-3) -Format "yyyy-MM-dd")

# Load Powershell snapin from VMware
# ignore all errors
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

# Connect ESX/vCenter Server
connect-viserver $vCenterName

$VMF = Get-VM $doVMname

# juet test get snapshot list for $doVMname
get-snapshot -vm $VMF

# take snapshoot
New-snapshot -VM $VMF -name $filenameFormat -Quiesce -Memory

# del old snapshoot
get-snapshot -VM $VMF -name $delfilenameFormat |  remove-snapshot  -confirm:$false
