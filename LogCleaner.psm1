# LogCleaner.psm1 module

Function Clean-Log {

  Param(
    [Parameter(Mandatory=$true)]
    [string]$LogFileName
  )
  
  # Set path 
  $logPath = "$PSScriptRoot\Log\"  
    # Construct full log file path
    $logName = Split-Path -Leaf $LogFileName
    $logFilePath = Join-Path -Path $logPath -ChildPath $logName

  # Read log file content
$Parameters = @{
	Path = $logFilePath
}
  $logFileContent = Get-Content @Parameters

  # Output file path
  $outputFile = "$logPath$($LogName -replace '\.txt$', '_clean.txt')" 
  
  foreach ($logLine in $logFileContent){

    if ($logLine -ne ""){
    
      # Clean line
      $cleanLine = ?<BalancedBrackets> -Remove $logLine  
      $cleanLine = ?<BalancedParenthesis> -Remove $cleanLine

      # Output cleaned line    
      Out-File -FilePath $outputFile -InputObject $cleanLine -Append
    }
  }

}