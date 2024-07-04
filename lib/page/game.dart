import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../util/dto.dart';
import '../util/language.dart';
import '../util/storage.dart';
import '../widget/custom_add_game.dart';
import '../widget/custom_page_route.dart';
import 'detail.dart';

final GlobalKey<NavigatorState> navGameKey = GlobalKey<NavigatorState>();

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.searchedGames, required this.updateLibraryGames, this.showCircularIndicator});

  final List<Game> searchedGames;
  final UpdateLibraryFunction updateLibraryGames;
  final bool? showCircularIndicator;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String _selectedGameId = '';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navGameKey,
      onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Padding(
                padding: const EdgeInsets.all(30),
                child: widget.showCircularIndicator != null && widget.showCircularIndicator == true
                    ? const Center(child: SizedBox(height: 60, width: 60, child: CircularProgressIndicator(color: Colors.white)))
                    : widget.searchedGames.isEmpty
                        ? Center(
                            child: Text(
                            AppLocalizations.of(context)!.notFound,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          ))
                        : SingleChildScrollView(
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: widget.searchedGames.map((game) {
                                game = game as OnlineGame;
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        widget.updateLibraryGames([game], true, false);
                                      },
                                      onHover: (isSelected) {
                                        setState(() {
                                          _selectedGameId = isSelected ? game.id : '';
                                        });
                                      },
                                      child: Container(
                                        height: 240,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(game.coverImageUrl, headers: cacheHeader, cacheManager: cacheManager),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(children: [
                                          if (_selectedGameId == game.id) ...[
                                            const Spacer(),
                                            SizedBox(
                                              height: 40,
                                              width: 130,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF00D3C4),
                                                ),
                                                onPressed: () {
                                                  widget.updateLibraryGames([game], false, true);
                                                  navGameKey.currentState!.push(
                                                    CustomPageRoute(
                                                      child: DetailPage(game: game as OnlineGame, runTrainer: true),
                                                    ),
                                                  );
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
                                      width: 160,
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(getGameName(game.name, game.nameZh), textAlign: TextAlign.center),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
              )),
    );
  }
}
