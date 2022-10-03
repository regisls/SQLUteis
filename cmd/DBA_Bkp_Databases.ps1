$bkpScriptsPath = "C:\Folder\From\BackupScripts"
$bakFilesPath = "C:\Folder\From\MSSQL\BAK\Backup"

$WinRar = "C:\Program Files\WinRAR\winrar.exe"

Write-Host ("Starting databases backup...")

$sqlFiles = Get-ChildItem $bkpScriptsPath -Filter *.sql
for ($i = 0; $i -lt $sqlFiles.Count; $i++) {
	$sqlFile = '"' + $sqlFiles[$i].FullName + '"'
	
	Write-Host ("Executing SQL file " + $sqlFile)
	
	& sqlcmd -S "localhost\sqlexpress" -U "sa" -P "mySqlPwd" -i $sqlFile
}

Write-Host ("Starting backup files compression")

$bakfiles = Get-ChildItem $bakFilesPath -Filter *.bak
for ($i = 0; $i -lt $bakfiles.Count; $i++) {
	$infile = '"' + $bakfiles[$i].FullName + '"'
	$outfile = '"' + $bakFilesPath + '\' + $bakfiles[$i].BaseName  + '.rar"'
	
	Write-Host ("Compressing " + $outfile + " file")
	
    & $WinRar a -ep $outfile $infile
    Get-Process winrar | Wait-Process
	
}
