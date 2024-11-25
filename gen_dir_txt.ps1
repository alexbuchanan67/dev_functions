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

# Function to recursively list files in the specified order
function Get-FilesAndFolders {
    param (
        [string]$CurrentDir,
        [array]$IgnoreFolders,
        [array]$IncludeExtensions
    )

    $result = @()

    # Get files at the current directory level matching the extensions
    $files = Get-ChildItem -Path $CurrentDir -File | Where-Object {
        $include = $false
        foreach ($ext in $IncludeExtensions) {
            if ($_.Name -like $ext) {
                $include = $true
                break
            }
        }
        $include
    } | Sort-Object -Property Name

    foreach ($file in $files) {
        $relativePath = $file.FullName -replace [regex]::Escape($BaseDir), ""
        $result += $relativePath.TrimStart("\") # Ensure relative paths don't have leading slashes
    }

    # Get child directories, excluding ignored folders
    $directories = Get-ChildItem -Path $CurrentDir -Directory | Where-Object {
        $ignore = $false
        foreach ($ignoreFolder in $IgnoreFolders) {
            if ($_.FullName -like "*$ignoreFolder*") {
                $ignore = $true
                break
            }
        }
        -not $ignore
    } | Sort-Object -Property Name

    # Process each child directory recursively
    foreach ($dir in $directories) {
        $relativePath = $dir.FullName -replace [regex]::Escape($BaseDir), ""
        $result += Get-FilesAndFolders -CurrentDir $dir.FullName -IgnoreFolders $IgnoreFolders -IncludeExtensions $IncludeExtensions
    }

    return $result
}

# Generate the file list
$fileList = Get-FilesAndFolders -CurrentDir $BaseDir -IgnoreFolders $ignoreFolders -IncludeExtensions $includeExtensions

# Save the list to the output file
$fileList -join "`r`n" | Out-File -FilePath $outputTextFile -Encoding utf8

Write-Host "Text file created: $outputTextFile"
