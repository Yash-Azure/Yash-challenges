Function getobjectvalue ($getvalue)
{

$nestedObjectcustom = @{
    "cloud"= @{
        "enabled" = $true
        "vendors" = @(
            "azure",
            "aws",
            "google"
        )
    } 
}

$nestedObjectcustom.$getvalue

}

getobjectvalue -getvalue cloud
(getobjectvalue -getvalue cloud).Keys
(getobjectvalue -getvalue cloud).values
