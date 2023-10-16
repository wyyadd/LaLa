import 'dart:io';

import 'package:flutter/material.dart';

Future<void> launchGame(String trainerPath, int appId, VoidCallback voidCallback) async {
  if (Platform.isLinux) {
    String home = Platform.environment['HOME']!;
    String steamPath = '$home/.local/share/Steam';
    await _validateDir(steamPath);
    String gamePath = '$steamPath/steamapps/compatdata/$appId';
    await _validateDir(gamePath);
    String protonPath = await _getProtonPath(gamePath);

    voidCallback();
    await Process.run(protonPath, [
      'run',
      trainerPath
    ], environment: {
      'STEAM_COMPAT_CLIENT_INSTALL_PATH': steamPath,
      'STEAM_COMPAT_DATA_PATH': gamePath,
    });
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
  if (protonPath == null) {
    throw Exception('proton not exist');
  }
  _validateDir(protonPath);
  return '$protonPath/proton';
}

Future<void> _validateDir(String path) async {
  var dir = Directory(path);
  bool exist = await dir.exists();
  if (!exist) {
    throw Exception('$path not found');
  }
}
