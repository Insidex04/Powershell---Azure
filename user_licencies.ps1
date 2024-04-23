#Nos conectamos
Connect-Graph -Scopes Organization.Read.All

# Obtener todos los usuarios
$usuarios = Get-MgUser -All | Select-Object -Property DisplayName,UserPrincipalName

# Iterar a través de cada usuario
foreach ($usuario in $usuarios) {
    # Obtener los detalles de la licencia para el usuario actual
    $detallesLicencia = Get-MgUserLicenseDetail -UserId $usuario.UserPrincipalName
    
    # Seleccionar Nombre, mail y tipo de licencia.
    $detallesLicencia | Select-Object @{Name="DisplayName"; Expression={$usuario.DisplayName}}, @{Name="UserPrincipalName"; Expression={$usuario.UserPrincipalName}}, SkuPartNumber
}
