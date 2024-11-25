# dev_functions - A Collection of Handy PowerShell Functions

This repository contains a collection of reusable PowerShell functions designed to help automate and streamline common development tasks. These functions are shared publicly for the benefit of my team, enabling you to easily integrate them into your own projects to save time and maintain consistency across workflows.

## Contents

- **PowerShell Scripts**: A collection of scripts that implement various helpful functions for development.
- **Usage Instructions**: Instructions on how to integrate these scripts into your VS Code environment for easy execution across multiple projects.

---

## Table of Contents

- [dev\_functions - A Collection of Handy PowerShell Functions](#dev_functions---a-collection-of-handy-powershell-functions)
  - [Contents](#contents)
  - [Table of Contents](#table-of-contents)
  - [Functions Available in This Repository](#functions-available-in-this-repository)
  - [How to Use These Functions in Your Project](#how-to-use-these-functions-in-your-project)
    - [**Option 1: Download or Clone the Repository**](#option-1-download-or-clone-the-repository)
  - [How to Contribute](#how-to-contribute)
  - [License](#license)

---

## Functions Available in This Repository

The `dev_functions` repository is organized by a series of PowerShell scripts, each one providing a specific development function. These functions are stored in the root folder and can be easily referenced in any VS Code workspace.

Example scripts in this repository:

- `generate-directory-structure.ps1`: <br> A script to generate and save a text file of the directory structure of the current folder and all its subfolders.



Each script is designed to be reusable and can be easily modified for specific use cases if needed.

---

## How to Use These Functions in Your Project

You can use the functions in this repository in your own projects by referencing them in your VS Code tasks or running them directly from the PowerShell command line. Here’s how you can integrate them into your workflow.

### **Option 1: Download or Clone the Repository**

1. **Clone the Repository**: Start by cloning the repository to a location on your machine:
   ```bash
   git clone https://github.com/yourusername/dev_functions.git

2. Use Locally: You can either use the functions directly from the cloned repository or copy the individual script files into your project’s folder structure as needed.

Option 2: Reference a Shared Location  
Alternatively, you can store the repository or individual scripts in a shared location, and reference them in any project you are working on. For example, you could place the scripts in a folder like .vscode/functions in your project directory. This way, the functions are easily portable and you can copy the folder between different projects.

Configuring VS Code Tasks  
To make it easy to run these functions in any project, you can configure VS Code tasks that map to the PowerShell scripts in this repository. Here's how to do it:

Create or Modify .vscode/tasks.json: In your project, navigate to the .vscode folder (or create one if it doesn't exist). Inside this folder, create or modify the tasks.json file to add custom tasks.

Add Tasks for Each Script: Below is an example of how to add tasks for the PowerShell scripts:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Generate Directory Structure",
            "type": "shell",
            "command": "powershell",
            "args": [
                "-ExecutionPolicy",
                "Bypass",
                "-File",
                "${workspaceFolder}/.vscode/functions/generate-directory-structure.ps1"
            ],
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        },
        {
            "label": "Clean Up Logs",
            "type": "shell",
            "command": "powershell",
            "args": [
                "-ExecutionPolicy",
                "Bypass",
                "-File",
                "${workspaceFolder}/.vscode/functions/cleanup-logs.ps1"
            ],
            "problemMatcher": []
        }
    ]
}
```

3. Run the Tasks: 
   Once the tasks are configured, you can run them directly from VS Code using the Command Palette (Ctrl + Shift + P) and typing Run Task. Select the task you want to run, and VS Code will execute the corresponding PowerShell script.

## How to Contribute
If you'd like to contribute to this repository, feel free to submit a pull request with any new functions or improvements to existing scripts. Please ensure that your code is well-documented and follows the formatting conventions of the repository.

## License
This project is licensed under the MIT License - see the LICENSE file for details.