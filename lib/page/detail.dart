import '../util/dto.dart';
import '../util/game_launcher.dart';
import '../util/language.dart';
import '../util/server.dart';
import '../util/storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final OnlineGame game;
  final bool? runTrainer;

  const DetailPage({super.key, required this.game, this.runTrainer});

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
        if (g.trainers.length != widget.game.trainers.length || g.trainers[0].trainerUrl != widget.game.trainers[0].trainerUrl) {
          setState(() {
            widget.game.trainers = g.trainers;
          });
        }
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
              child: Text(
                getTranslatedText(widget.game.name, widget.game.nameZh),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                textAlign: TextAlign.center,
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
                    : Text(getTranslatedText('Launch', '启动')),
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
      await launchGame(context, file.path, widget.game.appId, () {
        if (showCircularIndicator) {
          setState(() {
            showCircularIndicator = false;
          });
        }
      }, false);
    });
  }
}
