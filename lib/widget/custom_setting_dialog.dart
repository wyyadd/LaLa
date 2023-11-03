import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/storage.dart';

String selectedLanguage = 'English';
const List<String> languageOptions = ['English', '中文'];

String getTranslatedText(String english, String chinese) {
  return selectedLanguage == 'English' ? english : chinese;
}

class CustomSettingDialog extends StatefulWidget {
  const CustomSettingDialog({super.key, required this.updateLanguage});

  final ValueChanged<String> updateLanguage;

  @override
  State<CustomSettingDialog> createState() => _CustomSettingDialogState();
}

class _CustomSettingDialogState extends State<CustomSettingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF2E3466),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(getTranslatedText('Setting', '设置'), style: const TextStyle(color: Colors.grey)),
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  getTranslatedText('Language', '语言'),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: 100,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedLanguage,
                    dropdownColor: const Color(0xFF2E3466),
                    focusColor: Colors.transparent,
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue != selectedLanguage) {
                        setState(() {
                          widget.updateLanguage(newValue);
                        });
                      }
                    },
                    items: languageOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 5),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  getTranslatedText('Clear Cache', '清理缓存'),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D3C4),
                    ),
                    child: Text(getTranslatedText('Clear', '清理')),
                    onPressed: () {
                      cacheManager.emptyCache();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF2E3466),
                          content: Center(
                            child: Text(
                              getTranslatedText('Cache cleared successfully', '清理完成'),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "v1.0.2",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  launchUrl(Uri.parse('https://www.github.com/wyyadd/LaLa'));
                },
                child: const Text(
                  'Github',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
