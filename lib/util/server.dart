import 'dto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Server server = Server();

class Server {
  static const String hotListApi = 'https://api.aironheart.com/hottest';
  static const String searchApi = 'https://api.aironheart.com/search';

  Future<List<Game>> getHotList() async {
    try {
      final response = await http.get(Uri.parse(hotListApi));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<Game> parsedGames =
            (jsonDecode(response.body) as List<dynamic>).map((dynamic gameJson) => Game.fromJson(gameJson as Map<String, dynamic>)).toList();
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
            (jsonDecode(response.body) as List<dynamic>).map((dynamic gameJson) => Game.fromJson(gameJson as Map<String, dynamic>)).toList();
        return parsedGames;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
