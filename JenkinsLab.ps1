$labName = 'Jenkinslab1'

#create an empty lab template and define where the lab XML files and the VMs will be stored
New-LabDefinition -Name $labName -DefaultVirtualizationEngine HyperV -Path E:\AutomatedLabs -VmPath E:\AutomatedLab-VMs

#make the network definition
Add-LabVirtualNetworkDefinition -Name $labName -AddressSpace 192.168.81.0/24

Set-LabInstallationCredential -Username Install -Password Somepass1

#and the domain definition with the domain admin account
Add-LabDomainDefinition -Name test1.net -AdminUser Install -AdminPassword Somepass1

#the first machine is the root domain controller. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1DC1 -Memory 1024MB -Network $labName -IpAddress 192.168.81.10 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -Roles RootDC `
    -ToolsPath $labSources\Tools -OperatingSystem 'Windows Server 2019 Standard Evaluation (Desktop Experience)'

#the second just a member server. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name Jenkins1 -Memory 2048MB -Network $labName -IpAddress 192.168.81.21 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -ToolsPath $labSources\Tools `
    -OperatingSystem 'Windows Server 2019 Standard Evaluation'

#the third just a member server. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1Server1 -Memory 2048MB -Network $labName -IpAddress 192.168.81.22 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -ToolsPath $labSources\Tools `
    -OperatingSystem 'Windows Server 2019 Standard Evaluation'
    
# just a member server. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1Server2 -Memory 2048MB -Network $labName -IpAddress 192.168.81.22 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -ToolsPath $labSources\Tools `
    -OperatingSystem 'Windows Server 2019 Standard Evaluation'
    
# just a member server. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1Server3 -Memory 2048MB -Network $labName -IpAddress 192.168.81.23 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -ToolsPath $labSources\Tools `
    -OperatingSystem 'Windows Server 2019 Standard Evaluation'   
    

Install-Lab

Show-LabDeploymentSummary -Detailed
