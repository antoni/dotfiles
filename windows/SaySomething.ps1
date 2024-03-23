# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice

# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0

# Say something 
# TODO: Pass from command line
$voice.speak("Hey, Harcot, your BAT file is finished!")