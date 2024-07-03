import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dto.dart';

final Server server = Server();

class Server {
  static const String hotListApi = 'https://api.aironheart.com/hottest';
  static const String searchApi = 'https://api.aironheart.com/search';
  static const String versionApi = 'https://api.aironheart.com/version';
  static const String updateApi = 'https://api.aironheart.com/update';

  Future<List<Game>> getHotList() async {
    try {
      final response = await http.get(Uri.parse(hotListApi));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<Game> parsedGames =
            (jsonDecode(response.body) as List<dynamic>).map((dynamic gameJson) => OnlineGame.fromJson(gameJson as Map<String, dynamic>)).toList();
        return parsedGames;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Game>> searchGames(String query) async {
    try {
      final response = await http.get(Uri.parse('$searchApi?query=$query'));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<Game> parsedGames =
            (jsonDecode(response.body) as List<dynamic>).map((dynamic gameJson) => OnlineGame.fromJson(gameJson as Map<String, dynamic>)).toList();
        return parsedGames;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<String> getLatestVersion() async {
    try {
      final response = await http.get(Uri.parse(versionApi));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return response.body;
      } else {
        return "";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<OnlineGame?> getGameUpdate(String id) async {
    try {
      final response = await http.get(Uri.parse('$updateApi?id=$id'));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        OnlineGame game = OnlineGame.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        return game;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
