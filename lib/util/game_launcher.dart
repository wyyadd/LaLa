import 'dart:io';
import 'language.dart';
import 'package:flutter/material.dart';

String customSteamPath = "";

Future<void> launchGame(BuildContext context, String trainerPath, int appId, VoidCallback stopCircleIndicator, bool isCustomTrainer) async {
  try {
    await _launchGame(trainerPath, appId, stopCircleIndicator, isCustomTrainer);
  } catch (e) {
    if (context.mounted) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslatedText('Launch failed', '启动失败')),
            content: SelectableText(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text(getTranslatedText('ok', '确定')),
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

Future<void> _launchGame(String trainerPath, int appId, VoidCallback stopCircleIndicator, bool isCustomTrainer) async {
  if (!await File(trainerPath).exists()) {
    throw Exception(
      getTranslatedText("Trainer path not found.\n\nCurrent Path: $trainerPath", "未找到修改器路径。\n\n当前路径为: $trainerPath"),
    );
  }
  if (Platform.isLinux) {
    String home = Platform.environment['HOME']!;
    String steamPath = customSteamPath.isEmpty ? '$home/.local/share/Steam' : customSteamPath;
    if (!await _dirExist('$steamPath/steamapps')) {
      throw Exception(
        getTranslatedText(
            "Steam path not found.\n\nYou can specify the path in the settings.\n\nCurrent Path: $steamPath\n\nDefault Path: $home/.local/share/Steam",
            "未找到Steam路径。\n\n您可以在设置中指定路径。\n\n当前路径为: $steamPath\n\n默认路径为: $home/.local/share/Steam"),
      );
    }
    String gamePath = '$steamPath/steamapps/compatdata/$appId';
    if (isCustomTrainer || !await _dirExist(gamePath)) {
      int? nonSteamGameId = _getAppIdFromPS();
      if (nonSteamGameId == null) {
        if (isCustomTrainer) {
          throw Exception(getTranslatedText("Game not found. \n\nFor non-Steam games or custom trainers, make sure the game is running.",
              "游戏未找到。\n\n对于非Steam游戏或者自定义修改器，请确保游戏已启动。"));
        } else {
          throw Exception(getTranslatedText(
              "Game path not found. Please ensure the game is installed.\n\nFor non-Steam games or custom trainers, make sure the game is running.\n\nCurrent Path: $gamePath",
              "游戏路径未找到。请确保游戏已安装。\n\n对于非Steam游戏或者自定义修改器，请确保游戏已启动。\n\n当前路径为: $gamePath"));
        }
      } else {
        gamePath = '$steamPath/steamapps/compatdata/$nonSteamGameId';
      }
    }

    String protonPath = await _getProtonPath(gamePath);
    stopCircleIndicator();
    // in platpak sandbox
    if (Platform.environment['container'] != null) {
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

Future<String> _getProtonPath(String gamePath) async {
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
  if (protonPath == null || !await _dirExist(protonPath)) {
    throw Exception(getTranslatedText('Proton path not found.\n\nPlease ensure Proton is installed.\n\nCurrent Path: $protonPath',
        '未找到Proton路径。\n\n请确认已安装Proton。\n\n当前路径为: $protonPath'));
  }
  return '$protonPath/proton';
}

int? _getAppIdFromPS() {
  ProcessResult processResult;
  // in platpak sandbox
  if (Platform.environment['container'] != null) {
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

Future<bool> _dirExist(String path) async {
  return await Directory(path).exists();
}

Future<void> killAllTrainers() async {
  if (Platform.isLinux) {
    // in platpak sandbox
    if (Platform.environment['container'] != null) {
      Process.runSync('flatpak-spawn', ['--host', 'pkill', '-f', 'TrainerCacheData.*x-ms-dos-executable']);
    } else {
      Process.runSync('pkill', ['-f', 'TrainerCacheData.*x-ms-dos-executable']);
    }
  }
}
