# Notes


## Setting up automatic login to a Linux host from Windows
Do this from the user profile directory, i.e. C:\Users\jrnev.

Generate a key pair for the UI host.

`ssh-keygen`

Verify the ssh key pair

`ls .ssh`

Get the public key value.

`Get-Content C:\Users\jrnev\.ssh\id_ed25519.pub`

Copy the line returned.

Log onto the target host and update the authorized keys.

`ssh rodan.local`

`echo "your_copied_key" >> ~/.ssh/authorized_keys`
