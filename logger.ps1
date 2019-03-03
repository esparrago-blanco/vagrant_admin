Function Logger($script_name, $level, $message){
    Write-Host "[" (Get-Date) "]" ${script_name} ${level}, ${message}
}

