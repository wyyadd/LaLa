import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(color: Colors.grey)),
            backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFF2B2E63)),
            overlayColor: const WidgetStatePropertyAll<Color>(Color(0xFF494E86)),
            padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
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
