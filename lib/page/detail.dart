import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../util/dto.dart';
import '../util/game_launcher.dart';
import '../util/language.dart';
import '../util/server.dart';
import '../util/storage.dart';
import '../util/widget.dart';

class DetailPage extends StatefulWidget {
  final OnlineGame game;
  final bool? runTrainer;
  final VoidCallback? onGameUpdated;

  const DetailPage({super.key, required this.game, this.runTrainer, this.onGameUpdated});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool showCircularIndicator = false;
  bool portraitImage = true;

  @override
  void initState() {
    super.initState();
    if (widget.game.coverImageUrl.endsWith('header.jpg')) {
      portraitImage = false;
    }
    if (widget.runTrainer == true) {
      launchTrainer();
    }
    server.getGameUpdate(widget.game.id).then((g) {
      if (g != null && mounted) {
        setState(() {
          widget.game
            ..appId = g.appId
            ..name = g.name
            ..nameZh = g.nameZh
            ..specialNotes = g.specialNotes
            ..coverImageUrl = g.coverImageUrl
            ..trainers = g.trainers;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.game.coverImageUrl,
              height: portraitImage ? 360 : 258,
              width: portraitImage ? 240 : 552,
              httpHeaders: cacheHeader,
              cacheManager: cacheManager,
            ),
            Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: widget.game.specialNotes.isNotEmpty ? 90 : 40),
                  Flexible(
                    child: Text(
                      getGameName(widget.game.name, widget.game.nameZh),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (widget.game.specialNotes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(widget.game.specialNotes));
                        },
                        tooltip: AppLocalizations.of(context)!.specialNotes,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: const Icon(Icons.error_outline, color: Colors.orange, size: 24),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.grey, size: 24),
                    tooltip: AppLocalizations.of(context)!.setGameSteamPath,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      FilePicker.platform.getDirectoryPath().then((selectedDirectory) {
                        if (selectedDirectory != null) {
                          widget.game.customSteamPath = selectedDirectory;
                          if (widget.onGameUpdated != null) {
                            widget.onGameUpdated!();
                          }
                          if (!context.mounted) return;
                          showSnakeBar(
                            context: context,
                            message: AppLocalizations.of(context)!.gameSteamPathSet,
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 30),
                isExpanded: true,
                value: widget.game.selectedVersion ?? widget.game.trainers[0].versionName,
                dropdownColor: const Color(0xFF181E42),
                focusColor: Colors.transparent,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.game.selectedVersion = newValue;
                  });
                },
                items: widget.game.trainers.map<DropdownMenuItem<String>>((Trainer trainer) {
                  return DropdownMenuItem<String>(
                    value: trainer.versionName,
                    child: Center(child: Text(trainer.versionName, textAlign: TextAlign.center)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 170,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00D3C4)),
                onPressed: showCircularIndicator
                    ? null
                    : () {
                        launchTrainer();
                      },
                child: showCircularIndicator
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(AppLocalizations.of(context)!.launch),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchTrainer() async {
    setState(() {
      showCircularIndicator = true;
    });
    int index = widget.game.trainers.indexWhere((element) => element.versionName == widget.game.selectedVersion);
    if (index == -1) {
      index = 0;
    }
    await cacheManager.getSingleFile(widget.game.trainers[index].trainerUrl, headers: cacheHeader).then((file) async {
      await launchGame(
        context,
        file.path,
        widget.game.appId,
        () {
          if (showCircularIndicator) {
            setState(() {
              showCircularIndicator = false;
            });
          }
        },
        false,
        gameCustomSteamPath: widget.game.customSteamPath,
      );
    });
  }
}
