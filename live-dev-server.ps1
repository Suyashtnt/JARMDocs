$modulespath = ($env:psmodulepath -split ";")[0]
$pswatchpath = "$modulespath\pswatch"

Write-Host "Creating module directory"
New-Item -Type Container -Force -path $pswatchpath | out-null

Write-Host "Downloading and installing pswatch"
(new-object net.webclient).DownloadString("https://raw.github.com/jfromaniello/pswatch/master/pswatch.psm1") | Out-File "$pswatchpath\pswatch.psm1"

Import-Module pswatch

conda activate jarmdocs
$location = Get-Location

Write-Host "done, watching"
watch $location.Path -includeDeleted | ForEach-Object {
    Write-Output "Change made on $( $_.Path )"
    make html
}