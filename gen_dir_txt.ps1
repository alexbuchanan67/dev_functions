# Set the base folder path to the parent folder of the current script
$baseFolderPath = (Get-Item -Path $PSScriptRoot).Parent.FullName

# Set the output text file path in the same folder as the current script
$outputTextFile = Join-Path -Path $PSScriptRoot -ChildPath "filenames.txt"

# Define an array of folder paths to ignore
$ignoreFolders = @(
    "venv"
)

# Define an array of file extensions to include
$includeExtensions = @(
    "*.js",
    "*.json",
    "*.css",
    "*.py",
    "*.yml",
    "*.conf"

)

# Initialize a list to store the files
$fileList = @()

# Get files for each extension and add to the list
foreach ($extension in $includeExtensions) {
    $files = Get-ChildItem -Path $baseFolderPath -Recurse -File -Filter $extension | Where-Object {
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
    $relativePath = $file.FullName -replace [regex]::Escape($baseFolderPath), ""
    $outputContent += "$relativePath`r`n"
}

# Save the content to the text file
$outputContent | Out-File -FilePath $outputTextFile -Encoding utf8

Write-Host "Text file created: $outputTextFile"
