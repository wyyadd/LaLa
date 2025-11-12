// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'LaLa Trainer Launcher';

  @override
  String get library => 'Library';

  @override
  String get game => 'Game';

  @override
  String get specialNotes => 'Special Notes';

  @override
  String get launch => 'Launch';

  @override
  String get notFound => 'Oops, no results found. Try different keywords!';

  @override
  String get libraryEmpty => 'The game library is empty.\nSearch and add your favorites!';

  @override
  String get addTrainers => 'Add Trainers';

  @override
  String get gameName => 'Game Name:';

  @override
  String get trainerPath => 'Trainer Path:';

  @override
  String get select => 'Select';

  @override
  String get gameCover => 'Game Cover:\n(Optional)';

  @override
  String get trainerAdded => 'Trainer added successfully';

  @override
  String get save => 'Save';

  @override
  String get search => 'Search';

  @override
  String get setting => 'Setting';

  @override
  String get language => 'Language';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clear => 'Clear';

  @override
  String get cacheCleared => 'Cache cleared successfully';

  @override
  String get setSteamPath => 'Set Steam Path';

  @override
  String get set => 'Set';

  @override
  String get steamPathSet => 'Steam path set successfully';

  @override
  String get checkUpdate => 'Check Update';

  @override
  String get check => 'Check';

  @override
  String get supportMe => 'Support me';

  @override
  String get ok => 'OK';

  @override
  String newVersion(Object latestVersion) {
    return '🔥 New Version $latestVersion available!';
  }

  @override
  String get upToDate => '🎉 Already up to date';

  @override
  String get downloadLink => 'Download Link:';

  @override
  String protonPathNotFound(Object protonPath) {
    return 'Proton path not found.\n\nPlease ensure Proton is installed and the game uses Proton.\n\nCurrent Path: $protonPath';
  }

  @override
  String trainerPathNotFound(Object trainerPath) {
    return 'Trainer path not found.\n\nCurrent Path: $trainerPath';
  }

  @override
  String steamPathNotFound(Object defaultPath, Object steamPath) {
    return 'steamapps folder under Steam path not found.\n\nYou can specify the path in the settings.\n\nCurrent Path: $steamPath\n\nDefault Path: $defaultPath';
  }

  @override
  String gamePathNotFound(Object gamePath) {
    return 'Game path not found. Please ensure the game is installed.\n\nFor non-Steam games or custom trainers, make sure the game is running.\n\nCurrent Path: $gamePath';
  }

  @override
  String get customTrainerGamePathNotFound => 'Game not found. \n\nFor non-Steam games or custom trainers, make sure the game is running.';

  @override
  String get launchFail => 'Launch failed';

  @override
  String get loadGames => 'Load Games';

  @override
  String get load => 'load';

  @override
  String get gameLoaded => 'Games loaded successfully';

  @override
  String libraryPathNotFound(Object libraryPath) {
    return 'Library path not found.\n\nCurrent Path: $libraryPath';
  }

  @override
  String get setGameSteamPath => 'Set Steam Path for Game';

  @override
  String get gameSteamPathSet => 'Steam path set successfully for this game';
}
