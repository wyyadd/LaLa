import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/game_launcher.dart';
import '../util/game_loader.dart';
import '../util/language.dart';
import '../util/storage.dart';
import '../util/widget.dart';
import 'custom_add_game.dart';

class CustomSettingDialog extends StatefulWidget {
  const CustomSettingDialog({super.key, required this.updateLanguage, required this.latestVersion, required this.updateLibraryGames});

  final ValueChanged<String> updateLanguage;
  final String latestVersion;
  final UpdateLibraryFunction updateLibraryGames;

  @override
  State<CustomSettingDialog> createState() => _CustomSettingDialogState();
}

class _CustomSettingDialogState extends State<CustomSettingDialog> {
  String appVersion = "v1.0.0";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        appVersion = 'v${info.version}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF2E3466),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Setting -- Quit Button
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(AppLocalizations.of(context)!.setting, style: const TextStyle(color: Colors.grey)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.grey,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          // Language
          _rowWidget(
            AppLocalizations.of(context)!.language,
            DropdownButton<String>(
              isExpanded: true,
              value: selectedLanguage,
              dropdownColor: const Color(0xFF2E3466),
              focusColor: Colors.transparent,
              onChanged: (String? newValue) {
                if (newValue != null && newValue != selectedLanguage) {
                  setState(() {
                    widget.updateLanguage(newValue);
                  });
                  localStorage.writeConfig();
                }
              },
              items: languageOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 5),
          // Clear Cache
          _rowWidget(
            AppLocalizations.of(context)!.clearCache,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D3C4),
              ),
              child: Text(AppLocalizations.of(context)!.clear),
              onPressed: () {
                cacheManager.emptyCache();
                showSnakeBar(context: context, message: AppLocalizations.of(context)!.cacheCleared);
                Navigator.of(context).pop();
              },
            ),
          ),
          const Divider(height: 5),
          // Set steam path
          _rowWidget(
            AppLocalizations.of(context)!.setSteamPath,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D3C4),
              ),
              child: Text(AppLocalizations.of(context)!.set),
              onPressed: () {
                FilePicker.platform.getDirectoryPath().then((selectedDirectory) {
                  debugPrint('$selectedDirectory');
                  if (selectedDirectory != null) {
                    customSteamPath = selectedDirectory;
                    localStorage.writeConfig();
                    showSnakeBar(context: context, message: AppLocalizations.of(context)!.steamPathSet);
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ),
          const Divider(height: 5),
          // Load local games
          _rowWidget(
            AppLocalizations.of(context)!.loadGames,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D3C4),
              ),
              child: Text(AppLocalizations.of(context)!.load),
              onPressed: () async {
                String message = AppLocalizations.of(context)!.gameLoaded;
                try {
                  var games = await getLocalGames(context);
                  widget.updateLibraryGames(games, false, false);
                } catch (e) {
                  message = e.toString();
                  debugPrint(message);
                }
                if (!context.mounted) return;
                showSnakeBar(context: context, message: message, time: 2);
                Navigator.of(context).pop();
              },
            ),
          ),
          const Divider(height: 5),
          // check update
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.checkUpdate,
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (widget.latestVersion.isNotEmpty && widget.latestVersion != appVersion) ...[
                      const SizedBox(width: 2),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: const SizedBox(
                          width: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D3C4),
                    ),
                    child: Text(AppLocalizations.of(context)!.check),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return checkUpdateDialog();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Bottom: github--version--support
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  launchUrl(Uri.parse('https://www.github.com/wyyadd/LaLa'));
                },
                child: const Text(
                  'Github',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                appVersion,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  launchUrl(Uri.parse('https://ko-fi.com/LaLaLauncher'));
                },
                child: Text(
                  AppLocalizations.of(context)!.supportMe,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _rowWidget(String text, Widget element) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SizedBox(
            width: 100,
            child: element,
          ),
        ),
      ],
    );
  }

  Widget checkUpdateDialog() {
    bool newVersionAvailable = widget.latestVersion.isNotEmpty && widget.latestVersion != appVersion;
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Center(
        child: Text(newVersionAvailable ? AppLocalizations.of(context)!.newVersion(widget.latestVersion) : AppLocalizations.of(context)!.upToDate),
      ),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      content: SizedBox(
        height: 200,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.downloadLink,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D3C4),
                    ),
                    child: const Text("Github", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      launchUrl(Uri.parse('https://github.com/wyyadd/LaLa/releases'));
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D3C4),
                  ),
                  child: Text(AppLocalizations.of(context)!.ok, style: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
