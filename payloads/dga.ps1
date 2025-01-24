# Configure logging for verbose output
$LogPath = "$PSScriptRoot\DGA_Simulation.log"
$LogLevel = "DEBUG"

function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $Level - $Message"
    Add-Content -Path $LogPath -Value $logEntry
    if ($Level -eq "ERROR" -or $Level -eq "WARNING" -or $LogLevel -eq "DEBUG") {
        Write-Host $logEntry
    }
}

function Generate-Domain {
    # Generate a random domain name and TLD
    $nameLength = Get-Random -Minimum 5 -Maximum 11
    $tldLength = Get-Random -Minimum 2 -Maximum 4
    $domainName = -join ((65..90 + 97..122 + 48..57) | Get-Random -Count $nameLength | ForEach-Object {[char]$_})
    $tld = -join ((65..90 + 97..122) | Get-Random -Count $tldLength | ForEach-Object {[char]$_})
    $domain = "$domainName.$tld"
    Write-Log -Message "Generated domain: $domain" -Level "DEBUG"
    return $domain
}

function Query-Domains {
    param (
        [int]$NumQueries = 500,
        [double]$SleepTime = 0.01
    )
    for ($i = 0; $i -lt $NumQueries; $i++) {
        $domain = Generate-Domain
        try {
            [System.Net.Dns]::GetHostEntry($domain)
            Write-Log -Message "Queried domain: $domain" -Level "INFO"
        } catch {
            Write-Log -Message "Failed to query domain: $domain" -Level "WARNING"
        }
        Start-Sleep -Milliseconds ($SleepTime * 1000)
    }
}

function Download-File {
    $eicarUrl = "https://github.com/tyungchan/caldera-addon/blob/main/malware/eicar.com"
    try {
        $response = Invoke-WebRequest -Uri $eicarUrl -UseBasicParsing
        Write-Log -Message "EICAR file server response: $($response.StatusCode)" -Level "DEBUG"
        if ($response.StatusCode -eq 200) {
            $documentsPath = [System.Environment]::GetFolderPath('MyDocuments')
            $eicarPath = "${documentsPath}\eicar.com"
            $response.Content | Set-Content -Path $eicarPath -Encoding Byte
            Write-Log -Message "EICAR file downloaded and saved to: $eicarPath" -Level "INFO"
        } else {
            Write-Log -Message "Unexpected response from EICAR server: $($response.StatusCode)" -Level "WARNING"
        }
    } catch {
        Write-Log -Message "Failed to download EICAR file: $($_.Exception.Message)" -Level "ERROR"
    }
}

# Main execution
Write-Log -Message "Starting DGA simulation..." -Level "INFO"
Query-Domains -NumQueries 1000 -SleepTime 0.01
Download-File
Write-Log -Message "DGA simulation completed." -Level "INFO"

