param (
    [string]$BaseDir = "$PSScriptRoot",
    [string]$ConfigPath = "$BaseDir\.vscode\gen_dir_txt_config.json"
)

# Validate the BaseDir parameter
if (-not (Test-Path -Path $BaseDir)) {
    Write-Host "Base directory does not exist: $BaseDir"
    exit 1
}

# Validate the ConfigPath parameter
if (-not (Test-Path -Path $ConfigPath)) {
    Write-Host "Configuration file not found: $ConfigPath"
    exit 1
}

# Load the configuration
$config = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json
$ignoreFolders = $config.excludeFolders
$includeExtensions = $config.includeExtensions

# Set the output text file path in the specified base directory
$outputTextFile = Join-Path -Path (Join-Path -Path $BaseDir -ChildPath ".vscode") -ChildPath "filenames.txt"

# Initialize a list to store the files
$fileList = @()

# Get files for each extension and add to the list
foreach ($extension in $includeExtensions) {
    $files = Get-ChildItem -Path $BaseDir -Recurse -File -Filter $extension | Where-Object {
        $ignore = $false
        foreach ($ignoreFolder in $ignoreFolders) {
            if ($_.FullName -like "*$ignoreFolder*") {
                $ignore = $true
                break
            }
        }
        -not $ignore
    }
    $fileList += $files
}

# Initialize a string to store the content
$outputContent = ""

# Loop through each file and extract the relative path
foreach ($file in $fileList) {
    $relativePath = $file.FullName -replace [regex]::Escape($BaseDir), ""
    $outputContent += "$relativePath`r`n"
}

# Save the content to the text file
$outputContent | Out-File -FilePath $outputTextFile -Encoding utf8

Write-Host "Text file created: $outputTextFile"
