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
  <span style="font-size: 16px;"><a href="./README_zh.md">中文</a> - <a href="./README_de.md">German</a></span>
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
* MacOS (Coming Soon)

## ⚙️ Installation
You can download prebuilt binaries directly from [**GitHub releases**](https://github.com/wyyadd/LaLa/releases).
- For **Windows** user, install **exe** file directly.
- For **Linux** and **Steam deck** user, run one of the following commands to install.
    - AppImage version
    ```bash
    chmod +x LaLa_linux_amd64.AppImage && \
    ./LaLa_linux_amd64.AppImage
    ```
    - Flatpak version
    ```bash
    flatpak install --user LaLa_linux_amd64.flatpak && \
    flatpak run com.aironheart.lala
    ```
    - Binary version  
    ```bash
    unzip LaLa_linux_amd64.zip -d destination_folder && \
    chmod +x destination_folder/LaLa && \
    ./destination_folder/LaLa
    ```
    - Deb version: only for Debian-based and Ubuntu-based linux
    ```bash
    sudo dpkg -i LaLa_linux_amd64.deb && \
    LaLa
    ```
    
## ⚠️ Important notice for Linux and Steam Deck user
The LaLa Launcher for Linux relies on [**Proton**](https://github.com/ValveSoftware/Proton) to run trainers.   
To use trainers, you must:
- Install Steam and [set up Proton](docs/enable_proton.md).
- Have the game already installed.
- [Make sure the game uses Proton.](docs/enable_proton.md)

For **Steam Deck** users who use LaLa in **gaming mode**:
- Please add LaLa as a non-steam game.
- **Flatpak LaLa** is not supported for gaming mode.
- Use **Mouse Only** button Layout for better experience.

For users who use [Flatpak Steam](https://flathub.org/apps/com.valvesoftware.Steam), you need to:
- Add AppImage LaLa as a Non-Steam game.
- Use ```IN_FLATPAK_STEAM=1 %command% --appimage-extract-and-run``` as LaLa's launch options.
- Open LaLa through steam.

## 🙋 FAQ
### During installation, my operating system warns about security.
LaLa Trainers Launcher is an open-source software developed using Flutter. Any security warning you encounter during installation is a false positive from your system. You can safely proceed with the installation.

### Is the trainers downloaded by LaLa Trainers Launcher safe?
All of the trainers used by LaLa Trainers Launcher are sourced from [**Fling Trainers**](https://flingtrainer.com).
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
Servers aren't free and running/maintaining this project isn't free either😢.   
If you want to support me, you can [**buy me a coffee**](https://ko-fi.com/LaLaLauncher).  
<p align="center">
	<img src="https://github.githubassets.com/images/modules/site/sponsors/logo-mona.svg" height="200" width="200" alt="Mona logo"/>
</p>

