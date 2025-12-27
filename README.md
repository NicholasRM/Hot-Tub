# Hot Tub
A simple PowerShell script to automate copying files to archives.

## Contributions
***TL;DR: All pull requests and issues will be ignored or rejected. Please don't waste your time.***

This repository serves only to store the script so it can be cloned to new machines. This is barely maintained, and should be considered abandoned by anyone other than me. **I will not accept contributions by anyone other than myself.** If anyone submits them anyway, I will ignore or reject them. If you wish to maintain your own fork of the project, feel free to do so but please don't push any changes to this repository.

This project is licensed under the MIT License. This should technically be public domain but the MIT License accomplishes mostly the same thing.

## How to run
You can invoke the script by running it with a source directory and destination directory. For example:

```powershell
PS C:\Users\usern\> .\hottub.ps1 -SrcPath .\Documents -DestPath .\Backups
```

This will create a ZIP archive in the destination directory, whose name is the time the script was invoked.

Specifically, the format of the file name is `YYYYMMDDHHmmss.zip`. The exact time pulled is UTC by default. So if an archive is made at 10:53:57 EST on December 27, 2025, the resulting file will be named `20251227155357.zip`. This can be changed by including the `-LocalTime` parameter.

Additional text may be added to the beginning of the file by including the `-Name` variable and passing a string.

The script may also be invoked with the `-AutoDelete` parameter, which will forcefully and recursively delete the files in the source directory.

## Dependencies
The only dependency should be PowerShell 7. It may need to be manually installed on your machine, especially if you are running a non-Windows system, but this should be the only dependency you need. Other archiving tools like 7-Zip are probably faster than `Compress-Archive` and can compress in parallel, but the goal of this project was simplicity and minimal dependencies.