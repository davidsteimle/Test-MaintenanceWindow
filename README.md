# Test-MaintenanceWindow


```
NAME
    Test-MaintenanceWindow
    
SYNOPSIS
    
    
SYNTAX
    Test-MaintenanceWindow [-StartMaintenance] <Object> [-EndMaintenance] 
    <Object> [<CommonParameters>]
    
    
DESCRIPTION
    If you need to determine if the current time is in a specific range, for a 
    maintenance window, the comparison becomes difficult when the start of the 
    maintenance window is greater than the end of the maintenance window.
    
    This script builds an object of hours, and then assigns $true to the hours 
    which are part of the maintenance window. You can then determine if the 
    current hour is within the defined window.
    

PARAMETERS
    -StartMaintenance <Object>
        Start of the maintenance window with format "HH:mm"
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -EndMaintenance <Object>
        End of the maintenance window with format "HH:mm"
        
        Required?                    true
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
    (https://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS > Test-MaintenanceWindow -StartMaintenance '23:00' -EndMaintenance '05:00'
```
