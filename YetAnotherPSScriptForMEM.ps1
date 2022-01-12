<#
.SYNOPSIS
This script is used to manage MEM devices by PowerShell.
.DESCRIPTION
Base script with all functions, without any of split to the separate files.
.NOTES
Jakub Piesik (Piesik.me) © 2022
#>


If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Write-Output 'This script should be run with Administrator privileges'
    Break
}



if (Get-Module -ListAvailable -Name Microsoft.Graph.Intune) {
    Write-Host "Microsoft.Graph.Intune module is available. Going to the next step..."
    $isMSGraphIntuneAlreadyImported = Get-Module -name "Microsoft.Graph.Intune"
    if (!$isMSGraphIntuneAlreadyImported)
    {
        write-host "Module is not loaded. Loading it right now..."
        import-module Microsoft.Graph.Intune -Verbose
        write-host "Module was loaded"
    }
    else 
    {
        write-host "Module is already loaded. Nothing to do..."    
    }
} 
else {
    Write-Host "Microsoft.Graph.Intune module is not available. Installing it right now..."
    Install-Module -name Microsoft.Graph.Intune -force
    Import-Module -Name Microsoft.Graph.Intune -Verbose
}



#connecting to the MSGraph
$ConnectToMSGraph = Connect-MSGraph

write-host $ConnectToMSGraph.TenantID