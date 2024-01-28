## Editing Files and Adding Content to Your Git Repository (CLI)

Follow these steps when editing files or adding content to your Git repository using the command-line interface (CLI) in Visual Studio Code:

1. **Open Terminal:** <br>
   Open the integrated terminal in VS Code by clicking `Terminal > New Terminal` or using the shortcut `Ctrl+Backtick` (`` ` ``).

2. **Navigate to Project Directory:** <br>
   Use `cd` to navigate to your project directory.
   
```shell
   cd /path/to/your/project
```


3. **Check Status:** <br>
To see the current status of your project (tracked/untracked files), run:
```shell
git status
```


4. **Edit or Add Content:** <br>
Make your changes or add new content to your project files using VS Code.


5. **Stage Changes:** <br>
Stage all changes (including new files) for the next commit:
```shell
git add .
```
   OR, stage specific files or folders:
     
```shell
git add file-name
git add folder-name/
```


6. **Commit Changes:** <br>
Commit your changes with a descriptive message:
```shell
git commit -m "Your commit message here"
```


7. **Push Changes to Remote:** <br>
Push your commits to the remote repository (e.g., GitHub):
```shell
git push origin main
```

Replace main with your branch name if necessary.

8. **Enter Credentials (If Prompted):** <br>
If it's your first push or if you're prompted for credentials, provide your GitHub username and password or a personal access token.


This process allows you to edit files, add content, and synchronize your changes with your online Git repository using the CLI in Visual Studio Code.

