function Test-MaintenanceWindow{
    <#
    .DESCRIPTION
    If you need to determine if the current time is in a specific range, for a maintenance window, the comparison becomes difficult when the start of the maintenance window is greater than the end of the maintenance window.

    This script builds an object of hours, and then assigns $true to the hours which are part of the maintenance window. You can then determine if the current hour is within the defined window.
    .EXAMPLE
    Test-MaintenanceWindow -StartMaintenance '23:00' -EndMaintenance '05:00'
    #>

    param(
        [Parameter(Mandatory=$true, HelpMessage="Enter a valid time with HH:mm format.")] 
        [ValidatePattern("\d{1,2}:\d{2}")]
        $StartMaintenance
        # Start of the maintenance window with format "HH:mm"
        ,
        [Parameter(Mandatory=$true, HelpMessage="Enter a valid time with HH:mm format.")] 
        [ValidatePattern("\d{1,2}:\d{2}")]
        $EndMaintenance
        # End of the maintenance window with format "HH:mm"
    )

    $StartMaintenance = $StartMaintenance | Get-Date
    $EndMaintenance = $EndMaintenance | Get-Date

    #Build an empty object of 24 hours
    $Hours = New-Object -Type PSObject | Select-Object h00,h01,h02,h03,h04,h05,h06,h07,h08,h09,h10,h11,h12,h13,h14,h15,h16,h17,h18,h19,h20,h21,h22,h23

    # Begin to fill in hour properties in $Hours
    $StartRange = [int32]$StartMaintenance.Hour
    $EndRange = [int32]$EndMaintenance.Hour
    $i = $StartRange

    # Use a -ne comparison for the while loop, because if your maintenance window ends at 0400, you do not want the 0400-0459 span to be in your maintenance window. Also, as the Start Maintenance might be greater than the End Maintenance, we need to be able to continue our loop until we get to a true end.
    while($i -ne $EndRange){
        # Since we are dealing with 2 digit numbers as strings, if the current hour response is -lt 10, we pad a zero and assign to [string]$ii
        if($i -lt 10){
            [string]$ii = "0$i"
        } else {
            [string]$ii = $i
        }

        # Assign $true to the selected $Hour.h$ii
        $Hours.("h$ii") = $true
        # Increase $i
        $i++
        # Since we are dealing with 24hrs, if $i is greater than 23, we need to go to 00 (midnight)
        if($i -gt 23){
            $i = 0
        }
    }

    # Get the current hour
    $CurrentHour = (Get-Date).Hour
    # As above, pad a zero if needed, and add "h" to create our property name.
    if($CurrentHour -lt 10){
        $CurrentHour = [string]"h0$CurrentHour"
    } else {
        $CurrentHour = [string]"h$CurrentHour"
    }
    
    # Test if current hour's property is true
    if($Hours.$CurrentHour){
        $true
    } else {
        $false
    }
}
