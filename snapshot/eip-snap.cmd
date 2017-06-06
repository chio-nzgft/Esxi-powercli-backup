#echo off

Title,Report Script &color 9e
for /f "usebackq delims=$" %%a in (`cd`) do (
  set SCRIPTDIR=%%a
)

(Set ScriptFile=C:\script\EIP_SNAP.ps1 )

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -psc "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\vim.psc1" -noe -c ". \"C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1\"";%ScriptFile%"
