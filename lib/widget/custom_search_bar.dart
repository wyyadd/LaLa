import 'package:flutter/material.dart';
import 'custom_setting_dialog.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> updateSearchGames;

  const CustomSearchBar({super.key, required this.updateSearchGames});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: SearchAnchor(
        viewBackgroundColor: const Color(0xFF494E86),
        viewConstraints: const BoxConstraints(maxWidth: 200, maxHeight: 300),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            leading: const Icon(Icons.search, color: Colors.grey),
            hintText: getTranslatedText('Search', '搜索'),
            hintStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(color: Colors.grey)),
            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF2B2E63)),
            overlayColor: const MaterialStatePropertyAll<Color>(Color(0xFF494E86)),
            padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
            onSubmitted: (prompt) {
              prompt = prompt.trim();
              if (prompt.isNotEmpty) {
                widget.updateSearchGames(prompt);
              }
            },
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return [];
        },
      ),
    );
  }
}
