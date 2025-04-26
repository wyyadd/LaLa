import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/app_localizations.dart';
import 'page/game.dart';
import 'page/library.dart';
import 'util/dto.dart';
import 'util/game_launcher.dart';
import 'util/language.dart';
import 'util/server.dart';
import 'util/storage.dart';
import 'widget/custom_add_game.dart';
import 'widget/custom_search_bar.dart';
import 'widget/custom_setting_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStorage.initCacheManager();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static setLocal(BuildContext context, String local) {
    context.findAncestorStateOfType<_MyAppState>()?._setLocale(local);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _setLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaLa Trainers Launcher',
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF181E42),
        useMaterial3: false,
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
  static const int tabLength = 2;
  bool showBackButton = false;
  String latestVersion = "";

  LibraryPage libraryPage = LibraryPage(libraryGames: const [], updateBackButton: () {});
  GamePage gamePage = GamePage(searchedGames: const [], updateLibraryGames: (game, switchTab, showBackButton) {});

  List<Game> libraryGames = [];
  List<Game> hotListGames = [];

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true).then((value) => setState(() {}));
    tabController = TabController(length: tabLength, vsync: this);
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
      gamePage = GamePage(searchedGames: const [], updateLibraryGames: updateLibraryGames, showCircularIndicator: true);
    });
    var games = await server.searchGames(prompt);
    setState(() {
      gamePage = GamePage(searchedGames: games, updateLibraryGames: updateLibraryGames);
      showBackButton = true;
    });
  }

  void updateLibraryGames(List<Game> games, bool switchTab, bool showBackButton) {
    for (var game in games) {
      final existingGameIndex = libraryGames.indexWhere((existingGame) => existingGame.id == game.id);
      if (existingGameIndex != -1) {
        libraryGames.removeAt(existingGameIndex);
        libraryGames.insert(0, game);
      } else {
        libraryGames.insert(0, game);
      }
    }
    // save game library
    localStorage.writeGameList(libraryGames, libraryFileName);
    setState(() {
      libraryPage = LibraryPage(libraryGames: libraryGames, updateBackButton: updateBackButton);
    });
    if (switchTab) {
      tabController.animateTo(0);
    }
    if (showBackButton) {
      updateBackButton();
    }
  }

  void updateLanguage(String newLanguage) {
    selectedLanguage = newLanguage;
    MyApp.setLocal(context, languageToLocale(selectedLanguage));
  }

  void updateBackButton() {
    setState(() {
      showBackButton = true;
    });
  }

  void _loadConfig() async {
    Map<String, dynamic>? config = await localStorage.readConfig();
    if (config != null) {
      String language = config['language'] ?? languageOptions[0];
      if (language != selectedLanguage && languageOptions.indexWhere((element) => element == language) != -1) {
        updateLanguage(language);
      }
      customSteamPath = config['custom_steam_path'] ?? "";
    }
    configLoaded = true;
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
    gameLoaded = true;
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
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      await localStorage.writeConfig();
      await localStorage.writeGameList(libraryGames, libraryFileName);
      await killAllTrainers();
      await windowManager.destroy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
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
                  tabs: <Tab>[
                    Tab(text: AppLocalizations.of(context)!.library),
                    Tab(text: AppLocalizations.of(context)!.game),
                  ],
                ),
                const Spacer(),
                CustomSearchBar(updateSearchGames: updateSearchGames),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.grey,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => CustomAddGame(updateLibraryGames: updateLibraryGames),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.grey,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => CustomSettingDialog(
                        updateLanguage: updateLanguage,
                        latestVersion: latestVersion,
                        updateLibraryGames: updateLibraryGames,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  color: Colors.grey,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    onWindowClose();
                  },
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
