String selectedLanguage = 'English';
const List<String> languageOptions = ['English', '中文'];

String getTranslatedText(String english, String chinese) {
  return selectedLanguage == 'English' ? english : chinese;
}
