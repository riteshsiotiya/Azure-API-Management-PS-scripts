

param(
    [string]$AzureResourceGroupName,
    [string]$AzureServiceName,
    [string]$OAuthServerId,
    [string]$OAuthServerName,
    [string]$ClientRegistrationPageUrl,
    [string]$AuthorizationEndpointUrl,
    [string]$TokenEndpointUrl,
    [string]$ClientId,
    [string]$ClientSecret,
    [string[]]$AuthorizationRequestMethods,
    [string[]]$GrantTypes,
    [string[]]$ClientAuthenticationMethods,
    [hashtable]$TokenBodyParameters,
    [string[]]$AccessTokenSendingMethods
)

Write-Host "=========================================================================
           Azure Api Management service OAuth2.0 server creation 
=========================================================================" -ForegroundColor Green 
Get-AzSubscription

Write-Host "Verifying if requested OAuth server is alredy exist or not..."

$ApiMgmtContext = New-AzApiManagementContext -ResourceGroupName $AzureResourceGroupName -ServiceName $AzureServiceName
$getApiMgtOAuthServer = Get-AzApiManagementAuthorizationServer -Context $ApiMgmtContext -ServerId $OAuthServerId

if($getApiMgtOAuthServer)
{
    Write-Host "APIM OAuth2.0 server: $OAuthServerId is already exist" -ForegroundColor Yellow
}
else
{
    Write-Host "APIM OAuth2.0 server: $OAuthServerId does not exist" -ForegroundColor Green
    Write-Host "Azure Api Management service OAuth2.0 server creation started..."
    New-AzApiManagementAuthorizationServer -Context $ApiMgmtContext -ServerId $OAuthServerId -Name $OAuthServerName -ClientRegistrationPageUrl $ClientRegistrationPageUrl -AuthorizationEndpointUrl $AuthorizationEndpointUrl -TokenEndpointUrl $TokenEndpointUrl -ClientId $ClientId -ClientSecret $ClientSecret -AuthorizationRequestMethods @($AuthorizationRequestMethods) -GrantTypes @($GrantTypes) -ClientAuthenticationMethods @($ClientAuthenticationMethods) -TokenBodyParameters $TokenBodyParameters -AccessTokenSendingMethods @($AccessTokenSendingMethods)
}

#New-AzApiManagementAuthorizationServer -Context $context -Name "OAuth2-server-pipeline" -ClientRegistrationPageUrl "https://localhost" -AuthorizationEndpointUrl "https://login.microsoftonline.com/582259a1-dcaa-4cca-b1cf-e60d3f045ecd/oauth2/authorize" -TokenEndpointUrl "https://login.microsoftonline.com/582259a1-dcaa-4cca-b1cf-e60d3f045ecd/oauth2/token" -ClientId "f2db16a5-08b7-4b96-94c2-207dcbaabe0c" -ClientSecret "9IV5?6XYiH9msCT-QHxgNfvVQjzNsY_[" -AuthorizationRequestMethods @('Get', 'Post') -GrantTypes AuthorizationCode -ClientAuthenticationMethods Body -TokenBodyParameters @{'Resource'='f2db16a5-08b7-4b96-94c2-207dcbaabe0c'} -AccessTokenSendingMethods AuthorizationHeader