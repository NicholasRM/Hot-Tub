Param(
    [string]$SrcPath,
    [string]$DestPath,
    [string]$Name,
    [switch]$Help,
    [switch]$AutoDelete,
    [switch]$LocalTime
)

if ($Help) {
    Write-Host "Hot Tub File Archiver - File backup script for Windows clients`nv1.0 - Nicholas Mendes`n`nOptions:`n`t-Help: Displays this message`n`t-SrcPath `$Path: Specifies the directory to copy`n`t-DestPath `$Path: Specifies the directory to store the archive.`n`t-AutoDelete: If provided, deletes all archived files in `$SrcPath`n`t-LocalTime: If provided, uses computer's timezone for archive timestamp.`n`t-Name `$Name: If provided, appends `$Name to the timestamp with a hyphen (-) as a separator.`n`nAll archives are named using the date when the script was run in the format YYYYMMDDHHmmss, where HHmmss is the current Hour, Minute, and Second in UTC`nEx: An archive taken at 10:53:57 EST on December 27, 2025 would be called '20251227155357.zip'"
} else {
    if ($LocalTime) {
        $ArchiveName = "$(Get-Date -UFormat "%Y%m%d%H%M%S").zip"
    } else {
        $ArchiveName = "$(Get-Date -AsUTC -UFormat "%Y%m%d%H%M%S").zip"
    }

    if ($Name -ne "") {
        $ArchiveName = "$Name-$ArchiveName"
    }

    $compress = @{
        LiteralPath = "$SrcPath"
        CompressionLevel = "Fastest"
        DestinationPath = "$DestPath\$ArchiveName"
    }
    Compress-Archive @compress

    if ($AutoDelete) {
        Remove-Item -Path "$SrcPath\*" -Recurse -Force
    }
}