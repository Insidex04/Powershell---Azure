*# Obtener usuarios con filtro y ordenar por correo*

$users = get-MgUser -All -Property 'UserPrincipalName', 'OfficeLocation', 'mail', 'Id'

| Where-Object { $_.UserPrincipalName
-like "*@costoso.es" }

| Sort-Object mail

*# Iterar sobre cada usuario*

$users | ForEach-Object {

$user = $_

$licenseDetails = Get-MgUserLicenseDetail -UserId $user.Id

*# Mostrar resultados antes de quitar licencias*

[PSCustomObject]@{

UserPrincipalName = $user.UserPrincipalName

OfficeLocation = $user.OfficeLocation

Mail = $user.Mail

Licenses = $licenseDetails.SkuPartNumber -join ", "

}

*# Quitar cada licencia asignada al usuario*

if ($licenseDetails.Count
-gt 0) {

$removeLicenses = @()

foreach ($license in $licenseDetails) {

$removeLicenses += $license.SkuId

}

*# Ejecutar el comando para eliminar las
licencias usando Set-MgUserLicense*

Set-MgUserLicense -UserId $user.Id -AddLicenses @() -RemoveLicenses $removeLicenses

Write-Host "Licencias removidas para el usuario $($user.UserPrincipalName)"

} else {

Write-Host "No se encontraron licencias para el usuario $($user.UserPrincipalName)"

}

}
