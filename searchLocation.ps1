<#
    .SYNOPSIS
    Search Active Directory for user information.
    .DESCRIPTION
    Search Active Directory for user information based off of first and last name.
    .NOTES
    Author: Darrell Webb
#>
param(
	[string] $firstName,
	[string] $lastName,
    [string] $sapUser
)

	$filter1 = "Name -like '$lastName, $firstName*'"
	$filter2 = "Description -like '$firstName $lastName*'"
    $filter3 = "sapUsername -eq '$sapUser'"

if($lastName){
	Write-Host "`n Searching for employee information...`n "

    Get-ADUser -Filter $filter1 -Properties DisplayName, sapUsername, userPrincipalName, OfficePhone, Office, Division  |
	Format-Table -Property DisplayName, sapUsername, userPrincipalName, OfficePhone, Office, Division
}

else{
	Write-Host "`n ADUser search requires last name parameter...`n "
}

if($firstName){
	Write-Host "`n Searching for AD Computer information by first name...`n "
    Get-ADComputer -Filter $filter2 -Properties Description, IPv4Address, pwdLastSet | 
	Format-Table -Property Description, IPv4Address, DNSHostName
}

else{
	Write-Host "`n ADComputer search requires first name parameter...`n "
}

if($sapUser){ 
    Write-Host "`n Searching for user based off of sapUsername...`n "
    Get-ADUser -Filter $filter3 -Properties DisplayName, sapUsername, userPrincipalName, OfficePhone, Office, Division  |
	Format-Table -Property DisplayName, sapUsername, userPrincipalName, OfficePhone, Office, Division
    Get-ADComputer -Filter $filter3 -Properties Description, IPv4Address | 
	Format-Table -Property Description, IPv4Address, DNSHostName
}
else{
    Write-Host "`n Requires sapUserName...`n "
}
    
