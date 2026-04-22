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
  Ein kostenloser, plattformübergreifender Launcher zum einfachen Entdecken, Verwalten und Ausführen von Spiele-Trainern🤗.
</div>

# 👀 Screenshots
<div align="center">
  <img src="image/library.png" width=600 />
  <img src="image/game.png" width=600 />
  <img src="image/detail.png" width=600 />
</div>

## 💻 Unterstützte Plattformen
* Windows
* Linux
* Steam Deck
* macOS (Coming Soon)

## ⚙️ Installation
Sie können vorgefertigte Binärdateien direkt von [**GitHub releases**](https://github.com/wyyadd/LaLa/releases).
- Für Windows-Benutzer installiere die **exe**-Datei direkt.
- Für **Linux-** und **Steam Deck**-Benutzer, führen Sie einen der folgenden Befehle aus, um die Installation durchzuführen.
  - AppImage-Version
    ```bash
    chmod +x LaLa_linux_amd64.AppImage && \
    ./LaLa_linux_amd64.AppImage
    ```
  - Flatpak-Version
    ```bash
    flatpak install --user LaLa_linux_amd64.flatpak && \
    flatpak run com.aironheart.lala
    ```
  - Binärversion
    ```bash
    unzip LaLa_linux_amd64.zip -d destination_folder && \
    chmod +x destination_folder/LaLa && \
    ./destination_folder/LaLa
    ```
  - Deb-Version: nur für Debian-basierte und Ubuntu-basierte Linux
    ```bash
    sudo dpkg -i LaLa_linux_amd64.deb && \
    LaLa
    ```

## ⚠️ Wichtiger Hinweis für Linux- und Steam Deck-Benutzer
Der LaLa Launcher für Linux basiert auf [**Proton**](https://github.com/ValveSoftware/Proton), um Trainer auszuführen.  
Um Trainer einzusetzen, müssen Sie:
- Steam installieren und [Proton einrichten](docs/enable_proton.md).
- Das Spiel installiert haben.
- [Sicherstellen, dass das Spiel Proton verwendet.](docs/enable_proton.md)

Für **Steam Deck**-Benutzer, die LaLa im **Gaming-Modus** verwenden:
- Bitte fügen Sie LaLa als Nicht-Steam-Spiel hinzu.
- **Flatpak LaLa** wird im Gaming-Modus nicht unterstützt.
- Verwenden Sie das **Nur Maus**-Tastenlayout für eine bessere Erfahrung.

Für Benutzer, die [Flatpak Steam](https://flathub.org/apps/com.valvesoftware.Steam) verwenden, müssen Sie:
- Die AppImage LaLa als nicht Steam Spiel hinzufügen
- ```IN_FLATPAK_STEAM=1 %command% --appimage-extract-and-run``` als LaLas Startoption verwenden.
- Öffnen Sie LaLa über Steam.

## 📌 Häufige Probleme
### Probleme beim Einstellen des Steam-Pfads unter Linux
LaLa verwendet diesen Standardpfad: `~/.local/share/Steam`  
Wenn es nicht funktioniert, müssen Sie es möglicherweise manuell einstellen. Der Pfad muss den Ordner `steamapps` enthalten, damit LaLa Ihre Spiele finden kann.
#### Beispielpfade
- `~/.local/share/Steam`
- `~/.steam/steam`
- Flatpak:
  `~/.var/app/com.valvesoftware.Steam/.local/share/Steam`

### Trainer erkennt Spiele nicht
Wenn Trainer Ihr Spiel nicht erkennen können:
1. [Stellen Sie sicher, dass das Spiel Proton verwendet.](docs/enable_proton.md)
2. Starten Sie zuerst das Spiel und dann den Trainer.
3. Wenn es immer noch nicht funktioniert, versuchen Sie, auf eine andere Trainerversion umzusteigen.

## 🙋 FAQ
### Während der Installation gibt mein Betriebssystem eine Sicherheitswarnung aus.
LaLa Trainers Launcher ist eine Open-Source-Software, die mit Flutter entwickelt wurde. Jede Sicherheitswarnung, die Sie während der Installation sehen, ist ein Fehlalarm Ihres Systems. Sie können bedenkenlos mit der Installation fortfahren.

### Sind die vom LaLa Trainers Launcher heruntergeladenen Trainer sicher?
Die meisten von LaLa Trainers Launcher verwendeten Trainer stammen von [**Fling Trainers**](https://flingtrainer.com).
Obwohl alle Anstrengungen unternommen werden, um ihre Sicherheit zu gewährleisten, verwenden Sie sie bitte **verantwortungsvoll** und seien Sie sich bewusst, dass die Verwendung von Trainern Risiken bergen kann.

### Wo werden die Cache-Daten von LaLa Trainers Launcher gespeichert?
Unter Windows befinden sich die Cache-Daten im Verzeichnis „%LOCALAPPDATA%/com.aironheart.lala“.
Unter Linux ist es entweder in „$XDG_CACHE_HOME/com.aironheart.lala“ oder „~/.cache/com.aironheart.lala“ zu finden.

### Warum starten einige Trainer unter Linux oder Steam Deck nicht?
Dies ist ein Problem im Zusammenhang mit .Net-Abhängigkeiten. Weitere Informationen finden Sie in [dieser Ausgabe](https://github.com/madewokherd/wine-mono/issues/167).
**Vorübergehende Lösung**: [dotnet40 neu installieren](docs/reinstall_dotnet40.md).

### Warum flackern einige Trainer im Linux- oder Steam Deck-Gaming-Modus ständig?
Dies ist ein Problem im Zusammenhang mit Wayland. Weitere Informationen finden Sie in [dieser Ausgabe](https://github.com/wyyadd/LaLa/issues/6).
**Vorübergehende Lösung**: Wechseln Sie von Wayland zu X11 oder [Virtual Desktop aktivieren] (docs/enable_virtual_desktop.md).

### Warum heißt es LaLa Trainers Launcher?
Es ist nach meiner Liebe zum Film „La La Land“ benannt. Ich wünsche Ihnen viel Spaß mit der Software.💃🏽

## ☕ Unterstützung
Server sind nicht kostenlos und die Ausführung/Wartung dieses Projekts ist auch nicht kostenlos😢.
Wenn Sie mich unterstützen möchten, können Sie [**mir einen Kaffee spendieren**](https://ko-fi.com/LaLaLauncher).
<p align="center">
	<img src="https://github.githubassets.com/images/modules/site/sponsors/logo-mona.svg" height="200" width="200" alt="Mona logo"/>
</p>

