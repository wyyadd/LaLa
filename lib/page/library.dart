import 'dart:io';
import 'detail.dart';
import '../util/dto.dart';
import '../util/language.dart';
import '../util/storage.dart';
import '../util/game_launcher.dart';
import '../widget/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navLibraryKey = GlobalKey<NavigatorState>();

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key, required this.libraryGames, required this.updateBackButton});

  final List<Game> libraryGames;
  final VoidCallback updateBackButton;

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String _selectedGameId = '';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navLibraryKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Padding(
          padding: const EdgeInsets.all(30),
          child: widget.libraryGames.isEmpty
              ? Center(
                  child: Text(
                  AppLocalizations.of(context)!.libraryEmpty,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ))
              : SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: widget.libraryGames.map((game) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              widget.libraryGames.remove(game);
                              widget.libraryGames.insert(0, game);
                              // save game library
                              localStorage.writeGameList(widget.libraryGames, libraryFileName);
                              if (game is OnlineGame) {
                                widget.updateBackButton();
                                await navLibraryKey.currentState!.push(
                                  CustomPageRoute(
                                    child: DetailPage(game: game),
                                  ),
                                );
                              } else {
                                setState(() {});
                                await launchGame(context, (game as CustomGame).trainerPath, game.appId, () {}, true);
                              }
                            },
                            onHover: (isSelected) {
                              setState(() {
                                _selectedGameId = isSelected ? game.id : '';
                              });
                            },
                            child: Container(
                              height: 300,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: game is OnlineGame
                                    ? DecorationImage(
                                        image: CachedNetworkImageProvider(game.coverImageUrl, headers: cacheHeader, cacheManager: cacheManager),
                                        fit: BoxFit.cover,
                                      )
                                    : (game as CustomGame).coverImagePath.isNotEmpty
                                        ? DecorationImage(
                                            image: FileImage(File(game.coverImagePath)),
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage('image/default_game_cover.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                              ),
                              child: Column(children: [
                                if (_selectedGameId == game.id) ...[
                                  Container(
                                    color: Colors.black.withOpacity(0.3),
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel_outlined),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          widget.libraryGames.remove(game);
                                        });
                                        // save game library
                                        localStorage.writeGameList(widget.libraryGames, libraryFileName);
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF00D3C4),
                                      ),
                                      onPressed: () async {
                                        widget.libraryGames.remove(game);
                                        widget.libraryGames.insert(0, game);
                                        // save game library
                                        localStorage.writeGameList(widget.libraryGames, libraryFileName);
                                        if (game is OnlineGame) {
                                          widget.updateBackButton();
                                          navLibraryKey.currentState!.push(
                                            CustomPageRoute(
                                              child: DetailPage(game: game, runTrainer: true),
                                            ),
                                          );
                                        } else {
                                          setState(() {});
                                          await launchGame(context, (game as CustomGame).trainerPath, game.appId, () {}, true);
                                        }
                                      },
                                      child: Text(AppLocalizations.of(context)!.launch),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                ]
                              ]),
                            ),
                          ),
                          Container(
                            width: 220,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              game is OnlineGame ? getGameName(game.name, game.nameZh) : game.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
