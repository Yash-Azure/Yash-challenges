# REST call provide us the output in Object format, no need to apply a conversion.

$dataByREST_v1=Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-12-13"
$dataByREST_v1.compute
$dataByREST_v1.compute.location

$dataByREST_v2=Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance/compute/?api-version=2021-12-13"
$dataByREST_v2
$dataByREST_v2.location

$dataByREST_v3=Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance/compute/location?api-version=2021-12-13&format=text"
$dataByREST_v3

$dataByREST_v4=Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance/network/interface/0?api-version=2021-12-13"
$dataByREST_v4.ipv4.ipAddress


# WEB call respondes with JSON format. To parse the data, we can use convertfrom-json cmdlet to parse the values.
$dataByweb = Invoke-WebRequest -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-12-13"
$dataByweb.Content
$formated_web_data = $dataByweb.Content | ConvertFrom-Json
$formated_web_data
$formated_web_data.compute
$formated_web_data.compute.name
