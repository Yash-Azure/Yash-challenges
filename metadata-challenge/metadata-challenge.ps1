# REST call provide us the output in Object format, no need to apply a conversion.

$dataByREST=Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
$dataByREST.compute
$dataByREST.compute.location

# WEB call respondes with JSON format. To parse the data, we can use convertfrom-json cmdlet to parse the values.
$dataByweb = Invoke-WebRequest -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
$dataByweb.Content
$formated_web_data = $dataByweb.Content | ConvertFrom-Json
$formated_web_data
$formated_web_data.compute
$formated_web_data.compute.name