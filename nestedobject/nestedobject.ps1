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