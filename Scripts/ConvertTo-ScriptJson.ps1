param (
    [Parameter(Mandatory = $true)]
    [string] $Path,

    [Parameter(Mandatory = $false)]
    [string] $VariableName
)

$json = (Get-Content $Path -Raw).Replace("    ","")|ConvertTo-Json -Compress

if($VariableName){
    Write-Host "##vso[task.setvariable variable=$VariableName]$json"
}
else {
    $json
}