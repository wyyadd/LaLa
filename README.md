<div align="center">
  <img width="160" src="image/LaLa_round.png">
  <h1>LaLa Trainers Launcher</h1>
  <div>
    <img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white">
    <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">
    <img src="https://img.shields.io/badge/steam-%23000000.svg?style=for-the-badge&logo=steam&logoColor=white">
  </div>
    <div>
    <img src="https://img.shields.io/badge/License-AGPL_v3-blue.svg">
  </div>
  A free and cross-platform trainers launcher for enhancing your gaming experience🤗.  
  <br><br>
  <span style="font-size: 16px;"><a href="./README_zh.md">简体中文</a></span>
</div>

# 👀 Screenshots
<div align="center">
  <img src="image/library.png" width=600 />
  <img src="image/game.png" width=600 />
  <img src="image/detail.png" width=600 />
</div>

## 💻 Supported platforms
* Windows
* Linux
* Steam Deck
* macOS (coming soon)

## ⚙️ Installation
You can download prebuilt binaries directly from [**GitHub releases**](https://github.com/wyyadd/LaLa/releases) or [**BiliBili**](https://www.bilibili.com/read/cv27455416)
- For Windows user, install **exe** file directly.
- For Linux user, run following commands to install.
    ```bash
    sudo dpkg -i LaLa_linux_amd64.deb
    or
    sudo apt install ./LaLa_linux_amd64.deb
    or
    flatpak install --user LaLa_linux_amd64.flatpak
    or
    run LaLa_linux_amd64.AppImage directly🥰
    ```
- For Steam Deck User, run following commands to install.
    ```bash
    flatpak install --user LaLa_linux_amd64.flatpak
    or
    run LaLa_linux_amd64.AppImage directly🥰
    ```

## ⚠️ Important notice for Linux user
The LaLa Launcher for Linux relies on [**Proton**](https://github.com/ValveSoftware/Proton) to run trainers. To use trainers, you must:
- Install Steam and set up Proton.
- Have the game already installed.

LaLa currently **don't support** [Flatpak version of Steam](https://flathub.org/apps/com.valvesoftware.Steam) ([#25](https://github.com/wyyadd/LaLa/issues/25)).

## 🙋 FAQ
### During installation, my operating system warns about security.
LaLa Trainers Launcher is an open-source software developed using Flutter. Any security warning you encounter during installation is a false positive from your system. You can safely proceed with the installation.

### Is the trainers downloaded by LaLa Trainers Launcher safe?
Most of the trainers used by LaLa Trainers Launcher are sourced from [**Fling Trainers**](https://flingtrainer.com), and a few are from [**open-source cheat tables**](https://github.com/wyyadd/trainers) that I've collected.   
While every effort is made to ensure their safety, please use them **responsibly**, and be aware that the use of trainers can carry risks.

### Where is LaLa Trainers Launcher's cache data stored?
On Windows, the cache data is located in the ```%LOCALAPPDATA%/com.aironheart.lala``` directory.  
On Linux, it can be found in either ```$XDG_CACHE_HOME/com.aironheart.lala``` or ```~/.cache/com.aironheart.lala```.

### On Linux or Steam Deck, why some trainers won't start?
This is an issue related to .Net dependencies. Please check [this issue](https://github.com/madewokherd/wine-mono/issues/167) for more details.   
**Temporary Solution**: [Reinstalling dotnet40](docs/reinstall_dotnet40.md).

### On Linux or Steam Deck Gaming mode, why some trainers keep flickering?
This is an issue related to wayland. Please check [this issue](https://github.com/wyyadd/LaLa/issues/6) for more details.  
**Temporary Solution**: Switch from wayland to X11 or [Enable Virtual Desktop](docs/enable_virtual_desktop.md).

### Why is it named LaLa Trainers Launcher?
It's named after my love for the movie "La La Land". I hope you can enjoy using the software.💃🏽

## ☕ Support
LaLa Trainers Launcher is an open source project that runs on donations.  
If you want to support me, you can [**buy me a coffee**](https://ko-fi.com/LaLaLauncher).

