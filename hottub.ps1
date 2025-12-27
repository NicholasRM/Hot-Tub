Param(
    [string]$SrcPath,
    [string]$DestPath,
    [string]$Name,
    [switch]$Help,
    [switch]$AutoDelete,
    [switch]$LocalTime
)

if ($Help) {
    Write-Host "Hot Tub File Archiver - File backup script for Windows clients"
    Write-Host "v1.0 - Nicholas Mendes"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "`t-Help: Displays this message"
    Write-Host "`t-SrcPath `$Path: Specifies the directory to copy"
    Write-Host "`t-DestPath `$Path: Specifies the directory to store the archive."
    Write-Host "`t-AutoDelete: If provided, deletes all archived files in `$SrcPath"
    Write-Host "`t-LocalTime: If provided, uses computer's timezone for archive timestamp."
    Write-Host "`t-Name `$Name: If provided, appends `$Name to the timestamp with a hyphen (-) as a separator."
    Write-Host ""
    Write-Host "All archives are named using the date when the script was run in the format YYYYMMDDHHmmss, where HHmmss is the current Hour, Minute, and Second in UTC"
    Write-Host "Ex: An archive taken at 10:53:57 EST on December 27, 2025 would be called '20251227155357.zip'"
} else {
    # Handle time option for archive timestamp
    if ($LocalTime) {
        $ArchiveName = "$(Get-Date -UFormat "%Y%m%d%H%M%S").zip"
    } else {
        $ArchiveName = "$(Get-Date -AsUTC -UFormat "%Y%m%d%H%M%S").zip"
    }

    # Appends name to archive
    if ($Name -ne "") {
        $ArchiveName = "$Name-$ArchiveName"
    }

    # Decision to use Compress-Archive over 7-Zip was to minimize dependencies to run the script.
    # Speed may not be high but it will work.
    # Archiving cloud files is subject to network latency
    Compress-Archive -Path $SrcPath -CompressionLevel "Fastest" -DestinationPath "$DestPath\$ArchiveName"

    if ($AutoDelete) {
        Remove-Item -Path "$SrcPath\*" -Recurse -Force
    }
}