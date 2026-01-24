# Usage:
# .\SaySomething.ps1 -text "Text"
param (
    [string]$text
)

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice

# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0

# Say something
$voice.speak($text)

