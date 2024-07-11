import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vdf/vdf.dart';

import 'dto.dart';
import 'game_launcher.dart';
import 'server.dart';

List<int> _getLocalAppIds(String vdfString) {
  List<int> appIds = [];
  Map<String, dynamic> decoded = vdf.decode(vdfString);
  for (var location in (decoded["libraryfolders"] as Map<dynamic, dynamic>).values) {
    appIds.addAll((location["apps"] as Map<dynamic, dynamic>).keys.map((k) => int.parse(k)));
  }
  return appIds;
}

Future<List<Game>> getLocalGames(BuildContext context) async {
  String defaultPath = Platform.isLinux ? "${Platform.environment['HOME']!}/.local/share/Steam" : "C:\\Program Files (x86)\\Steam";
  String steamPath = customSteamPath.isEmpty ? defaultPath : customSteamPath;
  if (!await dirExist('$steamPath/steamapps')) {
    if (!context.mounted) return [];
    throw Exception(AppLocalizations.of(context)!.steamPathNotFound(defaultPath, steamPath));
  }

  String libraryPath = Platform.isLinux ? '$steamPath/steamapps/libraryfolders.vdf' : "$steamPath\\steamapps\\libraryfolders.vdf";

  final libraryFile = File(libraryPath);
  if (!await libraryFile.exists()) {
    if (!context.mounted) return [];
    throw Exception(AppLocalizations.of(context)!.libraryPathNotFound(libraryPath));
  }

  final appIds = _getLocalAppIds(await libraryFile.readAsString());
  final games = server.getBatchGames(appIds);
  return games;
}
