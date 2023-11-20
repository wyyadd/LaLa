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
  免费、开源、跨平台
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
* macOS (coming soon)

## ⚙️ 安装
你可以直接从[**GitHub releases**](https://github.com/wyyadd/LaLa/releases) 或 [**BiliBili**](https://www.bilibili.com/read/cv27455416)下载安装包
- 对于Windows用户，直接安装**exe**文件
- 对于Linux用户，运行以下命令安装
    ```bash
    sudo dpkg -i LaLa_linux_amd64.deb
    或者
    sudo apt install ./LaLa_linux_amd64.deb
    或者
    flatpak install --user LaLa_linux_amd64.flatpak
    或者
    直接运行 LaLa_linux_amd64.AppImage
    ```
- 对于SteamDeck用户，运行以下命令安装
    ```bash
    flatpak install --user LaLa_linux_amd64.flatpak
    或者
    直接运行 LaLa_linux_amd64.AppImage
    ```

## ⚠️ Linux和Steam Deck用户的注意事项
LaLa启动器依赖[**Proton**](https://github.com/ValveSoftware/Proton)来运行修改器。要使用修改器，你必须:
- 已安装Steam和Proton
- 已安装修改器对应的游戏

LaLa目前**不支持** [Flatpak版本的Steam](https://flathub.org/apps/com.valvesoftware.Steam) ([#25](https://github.com/wyyadd/LaLa/issues/25))。

## 🙋 常见问题
### 在安装过程中，我的操作系统发出了安全警告。
LaLa启动器是基于Flutter开发的开源软件。  
在安装过程中出现的安全警告属于系统误报，您可以放心继续安装。

### LaLa启动器下载的修改器是否安全？
LaLa使用的大多数修改器都来自于[**风灵月影**](https://flingtrainer.com)，还有一些来自我于收集的开源修改器。  
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
LaLa启动器是一个依靠捐赠运行的开源项目。  
如果你想支持我，你可以[**电我牛牛**](https://afdian.net/a/LaLaLauncher).
