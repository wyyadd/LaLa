import 'dart:math';
import '../util/dto.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef UpdateLibraryFunction = void Function(Game game, bool switchTab, bool showBackButton);

class CustomAddGame extends StatefulWidget {
  const CustomAddGame({super.key, required this.updateLibraryGames});

  final UpdateLibraryFunction updateLibraryGames;

  @override
  State<CustomAddGame> createState() => _CustomAddGameState();
}

class _CustomAddGameState extends State<CustomAddGame> {
  TextEditingController gameNameController = TextEditingController();
  String? trainerPath;
  String? coverImagePath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF2E3466),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 400,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(AppLocalizations.of(context)!.addTrainers, style: const TextStyle(color: Colors.grey)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.grey,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.gameName, style: const TextStyle(fontSize: 15)),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: gameNameController,
                        decoration: const InputDecoration(border: OutlineInputBorder(), counterText: ""),
                        minLines: 1,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        maxLength: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.trainerPath, style: const TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D3C4),
                        ),
                        onPressed: trainerPath == null
                            ? () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["exe", "EXE"]);
                                if (result != null) {
                                  setState(() {
                                    trainerPath = result.files.single.path;
                                  });
                                }
                              }
                            : null,
                        child: Text(AppLocalizations.of(context)!.select),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.gameCover, style: const TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D3C4),
                        ),
                        onPressed: coverImagePath == null
                            ? () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                                if (result != null) {
                                  setState(() {
                                    coverImagePath = result.files.single.path;
                                  });
                                }
                              }
                            : null,
                        child: Text(AppLocalizations.of(context)!.select),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: 40,
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D3C4),
                    ),
                    onPressed: () {
                      if (gameNameController.text.isNotEmpty && trainerPath != null && trainerPath!.isNotEmpty) {
                        CustomGame game = CustomGame(
                          name: gameNameController.text,
                          appId: Random().nextInt(3000000000) + 1000000000,
                          coverImagePath: coverImagePath ?? "",
                          trainerPath: trainerPath!,
                        );
                        widget.updateLibraryGames(game, false, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor: const Color(0xFF2E3466),
                            content: Center(
                              child: Text(
                                AppLocalizations.of(context)!.trainerAdded,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
