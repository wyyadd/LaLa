import 'dart:io';
import 'dto.dart';
import 'dart:convert';
import 'file_system.dart';
import 'game_launcher.dart';
import 'language.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const String libraryFileName = 'library.json';
const String hotListFileName = 'hottest.json';
const String configFileName = 'config.json';
const String cacheKey = 'TrainerCacheData';
const Map<String, String> cacheHeader = {'x-file-psk': 'lala-trainers-launcher'};

final LocalStorage localStorage = LocalStorage();
late final CacheManager cacheManager;

class LocalStorage {
  Future<String> get localPath async {
    final directory = await getApplicationCacheDirectory();
    return '${directory.path}/config';
  }

  void initCacheManager() async {
    String path = await localPath;
    cacheManager = CacheManager(Config(
      cacheKey,
      stalePeriod: const Duration(days: 365),
      maxNrOfCacheObjects: 1000,
      fileSystem: NewFileSystem(cacheKey),
      repo: JsonCacheInfoRepository(path: '$path/$cacheKey.json'),
    ));
  }

  Future<List<Game>> readGameList(String fileName) async {
    try {
      final path = await localPath;
      final file = File('$path/$fileName');

      final contents = await file.readAsString();
      List<Game> parsedGames =
          (jsonDecode(contents) as List<dynamic>).map((dynamic gameJson) => Game.fromJson(gameJson as Map<String, dynamic>)).toList();
      return parsedGames;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>?> readConfig() async {
    try {
      final path = await localPath;
      final file = File('$path/$configFileName');

      final contents = await file.readAsString();
      var parsedGames = jsonDecode(contents) as Map<String, dynamic>;
      return parsedGames;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> writeConfig() async {
    final path = await localPath;
    final file = File('$path/$configFileName');
    String config = jsonEncode({'language': selectedLanguage, 'custom_steam_path': customSteamPath});
    file.writeAsString(config);
  }

  Future<void> writeGameList(List<Game> games, String fileName) async {
    final path = await localPath;
    final file = File('$path/$fileName');
    file.writeAsString(jsonEncode(games));
  }
}
