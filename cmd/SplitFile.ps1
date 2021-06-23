$src = "C:\Caminho\do\arquivo\SQL_Grande.sql"
$dst = "C:\Caminho\do\arquivo\SQL_Parte-{0}.sql"
$reader = new-object IO.StreamReader($src)
$count = 1
$filename = ($dst -f ($count)) 

$row = 0
$MAX = 25000

$sb = new-object Text.StringBuilder
# Read the source row by row into a buffer
while(($line = $reader.ReadLine()) -ne $null){
    $row++
    [void]$sb.Append($line)
    [void]$sb.Append([Environment]::NewLine)

    # Till $MAX rows are read
    if($row -ge $MAX){
        # Write the buffer contents into a file and reset the buffer
        add-content -path $filename -value $($sb.ToString())
        $sb = new-object Text.StringBuilder
        ++$count
        $filename = ($dst -f ($count))
        $row = 0
    }
}
$reader.Close()