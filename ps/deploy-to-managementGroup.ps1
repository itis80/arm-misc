#Deploy to Azure management group

$templateFile = ""
$templateParameterFile = ""
$location = ""
$mgID = ""

New-AzManagementGroupDeployment -TemplateFile $templateFile -TemplateParameterFile $templateParameterFile -ManagementGroupId $mgID -Location $location