import 'detail.dart';
import '../util/dto.dart';
import '../util/storage.dart';
import '../widget/custom_page_route.dart';
import '../widget/custom_setting_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navLibraryKey = GlobalKey<NavigatorState>();

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key, this.libraryGames, required this.updateBackButton});

  final List<Game>? libraryGames;
  final VoidCallback updateBackButton;

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String _selectedGame = '';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navLibraryKey,
      onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Padding(
                padding: const EdgeInsets.all(30),
                child: widget.libraryGames == null || widget.libraryGames!.isEmpty
                    ? Center(
                        child: Text(
                        getTranslatedText('The game library is empty. Let\'s start adding games!', '游戏库中还没有游戏，快去添加吧！'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ))
                    : SingleChildScrollView(
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 20,
                          children: widget.libraryGames!.map((game) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    widget.libraryGames!.remove(game);
                                    widget.libraryGames!.insert(0, game);
                                    widget.updateBackButton();
                                    await navLibraryKey.currentState!.push(
                                      CustomPageRoute(
                                        child: DetailPage(game: game),
                                      ),
                                    );
                                  },
                                  onHover: (value) {
                                    setState(() {
                                      _selectedGame = value ? game.name : '';
                                    });
                                  },
                                  child: Container(
                                    height: 330,
                                    width: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(game.coverImageUrl, headers: cacheHeader, cacheManager: cacheManager),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(children: [
                                      if (_selectedGame == game.name) ...[
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
                                                widget.libraryGames!.remove(game);
                                              });
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
                                            onPressed: () {
                                              widget.updateBackButton();
                                              navLibraryKey.currentState!.push(
                                                CustomPageRoute(
                                                  child: DetailPage(game: game, runTrainer: true),
                                                ),
                                              );
                                            },
                                            child: Text(getTranslatedText('Launch', '启动')),
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
                                  child: Text(game.name, textAlign: TextAlign.center),
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
