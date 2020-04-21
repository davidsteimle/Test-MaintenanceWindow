# Test-MaintenanceWindow

For scripted deployments I often need to define a maintenance window, as we do not enforce them in SCCM.

Superficially it would be easy to do somethinf like:

```powershell
if(($CurrentTime -gt $StartMaint) -and ($CurrentTime -lt $EndMaint)){
    # Do something
}
```

But if your maintenance windows starts at 11pm and ends at 6am, then no attempt between 11pm and 12am will work.

The script here creates an object of 24 "hours", which are set to ``$true`` if they are in the maintenance window, then the current hour is compared to its hour to see if the maintenance window is active.

Minutes are ignored, but our parent script used an ``HH:mm`` format for time, which more easily casts as ``datetime``.

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

Example output of the ``$Hours`` object for a 23:00..06:00 maintenance window:

```
h00 : True
h01 : True
h02 : True
h03 : True
h04 : True
h05 : True
h06 :
h07 :
h08 :
h09 :
h10 :
h11 :
h12 :
h13 :
h14 :
h15 :
h16 :
h17 :
h18 :
h19 :
h20 :
h21 :
h22 :
h23 : True
```

``h06`` is not ``$true`` because if it were, then the window would go all the way to 07:00.
