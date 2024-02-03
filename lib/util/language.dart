String selectedLanguage = 'English';
const List<String> languageOptions = ['English', '中文', 'German'];

String languageToLocale(String language) {
  switch (language) {
    case 'English':
      return 'en';
    case '中文':
      return 'zh';
    case 'German':
      return 'de';
    default:
      return 'en';
  }
}

// Only support English and Chinese
String getGameName(String english, String chinese) {
  return selectedLanguage == '中文' ? chinese : english;
}
