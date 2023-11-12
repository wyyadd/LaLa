import '../util/dto.dart';
import '../util/language.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
                child: Text(getTranslatedText('Add Trainers', '添加修改器'), style: const TextStyle(color: Colors.grey)),
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
                    Text(getTranslatedText('Game Name:', ' 游戏名称:  '), style: const TextStyle(fontSize: 15)),
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
                    Text(getTranslatedText('Trainer Path:', '修改器路径:'), style: const TextStyle(fontSize: 15)),
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
                        child: Text(getTranslatedText('Select', '选择')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(getTranslatedText('Game Cover:\n  (Optional)', ' 游戏封面:   \n    (可选)'), style: const TextStyle(fontSize: 15)),
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
                        child: Text(getTranslatedText('Select', '选择')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D3C4),
                    ),
                    onPressed: () {
                      if (gameNameController.text.isNotEmpty && trainerPath != null && trainerPath!.isNotEmpty) {
                        CustomGame game = CustomGame(
                          name: gameNameController.text,
                          appId: Random().nextInt(3000000000)+1000000000,
                          coverImagePath: coverImagePath ?? "",
                          trainerPath: trainerPath!,
                        );
                        widget.updateLibraryGames(game, false, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF2E3466),
                            content: Center(
                              child: Text(
                                getTranslatedText('Trainer added successfully', '修改器添加成功'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(getTranslatedText('Save', '保存')),
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
