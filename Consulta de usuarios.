#Cambiamos las politicas de powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Instalamos el modulo
Install-Module Microsoft.Graph

#Importamos el modulo.
Import-Module Microsoft.Graph

#Nos conectamos a nuestro tenant con el siguiente comando y aceptamos los terminos y el actuar en nomvre del dominio.
Connect-MgGraph -Scopes Directory.Read.All,AuditLog.Read.All

#Ejecutamos el script para nos genere un excel con los datos 'UserPrincipalName','SignInActivity','Mail','DisplayName', 'AccountEnabled', 'LicenseAssignmentStates'.
Get-MgUser -All -Property 'UserPrincipalName','SignInActivity','Mail','DisplayName', 'AccountEnabled', 'LicenseAssignmentStates' | 
    Where-Object { $_.Mail -like "*@dominio.com" } |
    Select-Object @{
        N='UserPrincipalName';E={$_.UserPrincipalName}
    }, @{
        N='DisplayName';E={$_.DisplayName}
    }, @{
        N='LastSignInDate';E={$_.SignInActivity.LastSignInDateTime}
    }, @{
        N='AccountEnabled';E={$_.AccountEnabled}
    }, @{
        N='LicenseAssignmentStates';E={$_.LicenseAssignmentStates}
    }
| Export-excel -Path "C:\Users\Insidex04\Escritorio\LastLoging.xlsx" -AutoSize -AutoFilter -FreezeTopRow
