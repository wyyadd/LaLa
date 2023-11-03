import 'page/game.dart';
import 'page/library.dart';
import 'util/dto.dart';
import 'util/server.dart';
import 'util/storage.dart';
import 'package:flutter/material.dart';
import 'widget/custom_search_bar.dart';
import 'widget/custom_setting_dialog.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  localStorage.initCacheManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaLa Trainer Launcher',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF181E42),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener, SingleTickerProviderStateMixin {
  late final TabController tabController;
  List<Tab> tabs = <Tab>[
    Tab(text: getTranslatedText('Library', '库')),
    Tab(text: getTranslatedText('Game', '游戏')),
  ];
  bool showBackButton = false;
  String latestVersion = "";

  LibraryPage libraryPage = LibraryPage(updateBackButton: () {});
  GamePage gamePage = GamePage(updateLibraryGames: (game, switchTab) {});

  List<Game> libraryGames = [];
  List<Game> hotListGames = [];

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true).then((value) => setState(() {}));
    tabController = TabController(length: tabs.length, vsync: this);
    _loadConfig();
    _loadLocalGames();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void updateSearchGames(String prompt) async {
    navGameKey.currentState?.popUntil((route) => route.isFirst);
    tabController.animateTo(1);
    setState(() {
      gamePage = GamePage(updateLibraryGames: updateLibraryGames, showCircularIndicator: true);
    });
    var games = await server.searchGames(prompt);
    setState(() {
      gamePage = GamePage(searchedGames: games, updateLibraryGames: updateLibraryGames);
      showBackButton = true;
    });
  }

  void updateLibraryGames(Game game, bool switchTab) {
    final existingGameIndex = libraryGames.indexWhere((existingGame) => existingGame.name == game.name && existingGame.appId == game.appId);
    if (existingGameIndex != -1) {
      setState(() {
        libraryGames.removeAt(existingGameIndex);
        libraryGames.insert(0, game);
      });
    } else {
      setState(() {
        libraryGames.insert(0, game);
      });
    }
    // save game library
    localStorage.writeGameList(libraryGames, libraryFileName);
    if (switchTab) {
      tabController.animateTo(0);
    } else {
      setState(() {
        showBackButton = true;
      });
    }
  }

  void updateLanguage(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
      tabs = <Tab>[
        Tab(text: getTranslatedText('Library', '库')),
        Tab(text: getTranslatedText('Game', '游戏')),
      ];
    });
    // save config
    localStorage.writeConfig();
  }

  void updateBackButton() {
    setState(() {
      showBackButton = true;
    });
  }

  void _loadConfig() async {
    Map<String, dynamic>? config = await localStorage.readConfig();
    if (config != null) {
      String language = config['language'] as String;
      if (language != selectedLanguage && languageOptions.indexWhere((element) => element == language) != -1) {
        updateLanguage(language);
      }
    }
    latestVersion = await server.getLatestVersion();
  }

  void _loadLocalGames() async {
    if (libraryGames.isEmpty) {
      List<Game> games = await localStorage.readGameList(libraryFileName);
      setState(() {
        libraryGames = games;
        libraryPage = LibraryPage(libraryGames: libraryGames, updateBackButton: updateBackButton);
      });
    }
    if (hotListGames.isEmpty) {
      List<Game> localHotGames = await localStorage.readGameList(hotListFileName);
      if (localHotGames.isNotEmpty) {
        setState(() {
          hotListGames = localHotGames;
          gamePage = GamePage(searchedGames: hotListGames, updateLibraryGames: updateLibraryGames);
        });
      }
      List<Game> hotGames = await server.getHotList();
      if (hotGames.isNotEmpty) {
        setState(() {
          hotListGames = hotGames;
          gamePage = GamePage(searchedGames: hotListGames, updateLibraryGames: updateLibraryGames);
        });
        localStorage.writeGameList(hotListGames, hotListFileName);
      }
    }
  }

  @override
  void onWindowClose() async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(getTranslatedText('Are you sure you want to close this window?', '确定关闭窗口?')),
          actions: [
            TextButton(
              child: Text(getTranslatedText('No', '取消')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(getTranslatedText('Yes', '确定')),
              onPressed: () async {
                Navigator.of(context).pop();
                await localStorage.writeConfig();
                await localStorage.writeGameList(libraryGames, libraryFileName);
                await windowManager.destroy();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: const Icon(Icons.nightlight_outlined),
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: showBackButton
                      ? () {
                          setState(() {
                            gamePage = GamePage(searchedGames: hotListGames, updateLibraryGames: updateLibraryGames);
                            showBackButton = false;
                          });
                          navLibraryKey.currentState?.popUntil((route) => route.isFirst);
                          navGameKey.currentState?.popUntil((route) => route.isFirst);
                        }
                      : null,
                ),
                TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabs: tabs,
                ),
                const Spacer(),
                CustomSearchBar(updateSearchGames: updateSearchGames),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.grey,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => CustomSettingDialog(updateLanguage: updateLanguage, latestVersion: latestVersion),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(controller: tabController, children: [libraryPage, gamePage]),
      ),
    );
  }
}
