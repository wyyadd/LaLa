# How to reinstall dotnet40
## Step1: Install Wine and Winetricks
Before proceeding, make sure you have [Wine](https://www.winehq.org/) and [Winetricks](https://github.com/Winetricks/winetricks) installed on your system.
## Step 2: Backup the PFX Folder
Backup the PFX folder located at ```~/.steam/steam/steamapps/compatdata/{APPID}/pfx```   
{APPID} is the game ID. This step is **crucial** because the PFX folder contains your game data.  
You can create a backup at your home folder by running the following command:
```bash
cp -r ~/.steam/steam/steamapps/compatdata/{APPID}/pfx ~/pfx_backup
```
## Step 3: Reinstall dotnet40
Run the following command to reinstall dotnet40 within the WINEPREFIX.
```bash 
# delete all files inside pfx folder
WINEPREFIX=~/.steam/steam/steamapps/compatdata/{APPID}/pfx winetricks annihilate
# reinstall dotnet40
WINEPREFIX=~/.steam/steam/steamapps/compatdata/{APPID}/pfx winetricks dotnet40 win10
```
## Step 4: Restart the Game and Trainers
After reinstalling dotnet40, restart the game and trainers.  
You should now be able to launch them successfully.
