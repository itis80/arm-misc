#Deploy to Azure management group

$templateFile = ".\azuredeploy.json"
$templateParameterFile = ".\azuredeploy.parameters.json"
$location = ""
$mgID = ""

New-AzManagementGroupDeployment -TemplateFile $templateFile -TemplateParameterFile $templateParameterFile -ManagementGroupId $mgID -Location $location