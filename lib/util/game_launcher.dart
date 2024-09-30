import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String customSteamPath = "";

Future<void> launchGame(BuildContext context, String trainerPath, int appId, VoidCallback stopCircleIndicator, bool isCustomTrainer) async {
  try {
    await _launchGame(context, trainerPath, appId, stopCircleIndicator, isCustomTrainer);
  } catch (e) {
    if (context.mounted) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.launchFail),
            content: SelectableText(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } finally {
    stopCircleIndicator();
  }
}

Future<void> _launchGame(BuildContext context, String trainerPath, int appId, VoidCallback stopCircleIndicator, bool isCustomTrainer) async {
  if (!await File(trainerPath).exists()) {
    if (!context.mounted) return;
    throw Exception(AppLocalizations.of(context)!.trainerPathNotFound(trainerPath));
  }
  if (Platform.isLinux) {
    String home = Platform.environment['HOME']!;
    String defaultPath = "$home/.local/share/Steam";
    String steamPath = customSteamPath.isEmpty ? defaultPath : customSteamPath;
    if (!await dirExist('$steamPath/steamapps')) {
      if (!context.mounted) return;
      throw Exception(AppLocalizations.of(context)!.steamPathNotFound(defaultPath, steamPath));
    }
    String gamePath = '$steamPath/steamapps/compatdata/$appId';
    if (isCustomTrainer || !await dirExist(gamePath)) {
      int? nonSteamGameId = _getAppIdFromPS();
      if (nonSteamGameId == null) {
        if (!context.mounted) return;
        if (isCustomTrainer) {
          throw Exception(AppLocalizations.of(context)!.customTrainerGamePathNotFound);
        } else {
          throw Exception(AppLocalizations.of(context)!.gamePathNotFound(gamePath));
        }
      } else {
        gamePath = '$steamPath/steamapps/compatdata/$nonSteamGameId';
        if (!await dirExist(gamePath)) {
          if (!context.mounted) return;
          throw Exception(AppLocalizations.of(context)!.gamePathNotFound(gamePath));
        }
      }
    }

    if (!context.mounted) return;
    String protonPath = await _getProtonPath(context, gamePath);
    stopCircleIndicator();
    if (_inSandbox()) {
      await Process.run('flatpak-spawn', [
        '--host',
        '--env=STEAM_COMPAT_CLIENT_INSTALL_PATH=$steamPath',
        '--env=STEAM_COMPAT_DATA_PATH=$gamePath',
        protonPath,
        'run',
        trainerPath,
      ]);
    } else {
      await Process.run(protonPath, [
        'run',
        trainerPath
      ], environment: {
        'STEAM_COMPAT_CLIENT_INSTALL_PATH': steamPath,
        'STEAM_COMPAT_DATA_PATH': gamePath,
      });
    }
  } else {
    Process.run(trainerPath, []);
  }
}

Future<String> _getProtonPath(BuildContext context, String gamePath) async {
  String? protonPath;
  final configInfoFile = File('$gamePath/config_info');
  if (await configInfoFile.exists()) {
    final lines = await configInfoFile.readAsLines();
    if (lines.length >= 2) {
      var arr = lines[1].split('/');
      int index = arr.indexWhere((element) {
        return element.toLowerCase().contains('proton');
      });
      protonPath = arr.sublist(0, index + 1).join('/');
    }
  }
  if (protonPath == null) {
    if (!context.mounted) return "";
    throw Exception(AppLocalizations.of(context)!.protonPathNotFound("Null"));
  }
  if (!await dirExist(protonPath) && context.mounted) {
    throw Exception(AppLocalizations.of(context)!.protonPathNotFound(protonPath));
  }
  return '$protonPath/proton';
}

int? _getAppIdFromPS() {
  ProcessResult processResult;
  if (_inSandbox()) {
    processResult = Process.runSync('flatpak-spawn', ['--host', '/bin/sh', '-c', 'ps aux | grep "SteamLaunch AppId=" | grep -v -i "lala"']);
  } else {
    processResult = Process.runSync('/bin/sh', ['-c', 'ps aux | grep "SteamLaunch AppId=" | grep -v -i "lala"']);
  }
  if (processResult.exitCode == 0) {
    final outputLines = (processResult.stdout as String).split('\n');
    for (final line in outputLines) {
      final match = RegExp(r'SteamLaunch AppId=(\d+)').firstMatch(line);
      final appId = int.tryParse(match?.group(1) ?? '');
      if (appId != null) {
        return appId;
      }
    }
  }
  return null;
}

Future<bool> dirExist(String path) async {
  return await Directory(path).exists();
}

Future<void> killAllTrainers() async {
  if (Platform.isLinux) {
    if (_inSandbox()) {
      Process.runSync('flatpak-spawn', ['--host', 'pkill', '-f', 'TrainerCacheData.*x-ms-dos-executable']);
    } else {
      Process.runSync('pkill', ['-f', 'TrainerCacheData.*x-ms-dos-executable']);
    }
  }
}

bool _inSandbox() {
  // In flatpak sandbox
  if (Platform.environment['container'] == 'flatpak') {
    // In flatpak steam, LaLa should in be the same sandbox.
    if (Platform.environment['IN_FLATPAK_STEAM'] == '1') {
      return false;
    }
    return true;
  }
  return false;
}
