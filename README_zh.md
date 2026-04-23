<div align="center">
  <img width="160" src="image/LaLa_round.png">
  <h1>LaLa游戏修改器启动器</h1>
  <div>
    <img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white">
    <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">
    <img src="https://img.shields.io/badge/steam-%23000000.svg?style=for-the-badge&logo=steam&logoColor=white">
  </div>
  <div>
    <img src="https://img.shields.io/badge/License-AGPL_v3-blue.svg">
  </div>
  一个免费、跨平台的启动器，让你轻松发现、管理和运行游戏修改器🤗。
</div>

# 👀 截图
<div align="center">
  <img src="image/library.png" width=600 />
  <img src="image/game.png" width=600 />
  <img src="image/detail.png" width=600 />
</div>

## 💻 支持的平台
* Windows
* Linux
* Steam Deck
* macOS (Coming Soon)

## ⚙️ 安装
你可以直接从[**GitHub releases**](https://github.com/wyyadd/LaLa/releases)下载安装包。
- 对于Windows用户，直接安装**exe**文件
- 对于 **Linux** 和 **Steam deck** 用户, 运行以下命令之一进行安装。
  - AppImage 版本
    ```bash
    chmod +x LaLa_linux_amd64.AppImage && \
    ./LaLa_linux_amd64.AppImage
    ```
  - Flatpak 版本
    ```bash
    flatpak install --user LaLa_linux_amd64.flatpak && \
    flatpak run com.aironheart.lala
    ```
  - Binary 版本
    ```bash
    unzip LaLa_linux_amd64.zip -d destination_folder && \
    chmod +x destination_folder/LaLa && \
    ./destination_folder/LaLa
    ```
  - Deb 版本: 仅适用于基于Debian和Ubuntu的Linux系统 
    ```bash
    sudo dpkg -i LaLa_linux_amd64.deb && \
    LaLa
    ```

## ⚠️ Linux和Steam Deck用户的注意事项
LaLa启动器依赖[**Proton**](https://github.com/ValveSoftware/Proton)来运行修改器。
要使用修改器，你必须:
- 安装Steam和[开启Proton](docs/enable_proton.md)
- 已安装修改器对应的游戏
- [确保游戏使用Proton](docs/enable_proton.md)

对于在**游戏模式**下使用LaLa的**Steam Deck**用户：
- 请将LaLa添加为非Steam游戏。
- **Flatpak LaLa**在游戏模式下不受支持。
- 使用**Mouse Only**按钮布局以获得更好的体验。

对于使用[FlatPak Steam](https://flathub.org/apps/com.valvesoftware.Steam)的用户，你需要:
- 将AppImage LaLa添加为非Steam游戏
- 使用```IN_FLATPAK_STEAM=1 %command% --appimage-extract-and-run```作为LaLa的启动选项
- 从Steam启动LaLa

## 📌 常见问题
### Linux 下设置 Steam 路径的问题
LaLa 使用默认路径：`~/.local/share/Steam`  
如果不起作用，您可能需要手动设置。该路径必须包含 `steamapps` 文件夹，以便 LaLa 能够找到您的游戏。
#### 示例路径
- `~/.local/share/Steam`
- `~/.steam/steam`
- Flatpak:
  `~/.var/app/com.valvesoftware.Steam/.local/share/Steam`

### 修改器未检测到游戏
如果修改器无法检测到您的游戏：
1. [确保游戏使用 Proton。](docs/enable_proton.md)
2. 先启动游戏，然后再启动修改器。
3. 如果仍然不起作用，请尝试切换到不同的修改器版本。

## 🙋 常见问题
### 在安装过程中，我的操作系统发出了安全警告。
LaLa启动器是基于Flutter开发的开源软件。  
在安装过程中出现的安全警告属于系统误报，您可以放心继续安装。

### LaLa启动器下载的修改器是否安全？
LaLa使用的大多数修改器都来自于[**风灵月影**](https://flingtrainer.com)。
尽管我会尽最大努力确保它们的安全性，但还是请负责地使用它们，并注意使用修改器可能会带来风险。

### LaLa启动器的缓存数据存储在哪里？
在Windows中，位于```%LOCALAPPDATA%/com.aironheart.lala``` 文件夹。  
在Linux或Steam Deck中，位于 ```$XDG_CACHE_HOME/com.aironheart.lala```或```~/.cache/com.aironheart.lala```文件夹中。

### 在linux或SteamDeck中，为什么有些修改器无法启动?
这是一个与.Net依赖有关的问题，请参考该[GitHub问题](https://github.com/madewokherd/wine-mono/issues/167)以获取更多信息。  
临时解决方案：[重新安装dotnet40](docs/reinstall_dotnet40.md)。

### 在linux或SteamDeck的游戏模式中，为什么有些修改器一直闪烁?
这是一个与wayland有关的问题，请参考该[GitHub问题](https://github.com/wyyadd/LaLa/issues/6)以获取更多信息。  
临时解决方案： 从wayland切换到X11 或 [启动虚拟桌面](docs/enable_virtual_desktop.md)。

### 为什么把它被命名为LaLa？
它是以一部我很喜欢的电影《爱乐之城 (La La Land)》命名。希望您能享受使用这个软件。💃

## ☕ 支持我
服务器并不是免费的，运行/维护此项目也不是免费的😢。  
如果你想支持我，你可以[**电我牛牛**](https://afdian.net/a/LaLaLauncher)。  
<p align="center">
	<img src="https://github.githubassets.com/images/modules/site/sponsors/logo-mona.svg" height="200" width="200" alt="Mona logo"/>
</p>