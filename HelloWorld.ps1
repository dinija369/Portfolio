function Report {
    param (
        [string] $path,
        [DateTime] $dateTime
    )

    if ((Test-Path -Path $path -PathType Container)) {
        $files = Get-ChildItem -Path $path -Directory # or -File for files

        if ($files.Count -eq 0) {
            Set-Content -Path "Report.txt" -Value ""
            return
        }
    
        #$parsedDateTime = [datetime]::ParseExact($dateTime, "yyyyddMM-HHmm", $null)
    
        #$parsedDateTime = [datetime]"$dateTime"
    
        $filteredFiles = $files | Where-Object { $_.LastWriteTime -ge $dateTime }
    
        $sortedFiles = $filteredFiles | Sort-Object -Descending
    
        $reportFilePath = Join-Path -Path (Get-Location) -ChildPath "Report.txt"
    
        $sortedFiles | ForEach-Object {
            $_.Name | Out-File -Append -FilePath $reportFilePath
        }
    }

    else {
        "Directory does not exist!" | Out-File -FilePath "Report.txt"
        return
    }

}

Report -path "" -dateTime "25 Feb 2023 12:00"