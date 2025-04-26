// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'LaLa Trainer Starter';

  @override
  String get library => 'Bibiliothek';

  @override
  String get game => 'Spiel';

  @override
  String get specialNotes => 'Besondere Hinweise';

  @override
  String get launch => 'Starte';

  @override
  String get notFound => 'Ups, keine Ergebnisse gefunden. Versuche es mit anderen Schlüsselwörtern!';

  @override
  String get libraryEmpty => 'Die Spielebibliothek ist leer.\nSuche und füge deine Favoriten hinzu!';

  @override
  String get addTrainers => 'Trainer hinzufügen';

  @override
  String get gameName => 'Spiel Name:';

  @override
  String get trainerPath => 'Trainer Pfad:';

  @override
  String get select => 'Auswählen';

  @override
  String get gameCover => 'Spiel Cover:\n(Optional)';

  @override
  String get trainerAdded => 'Trainer erfolgreich hinzugefügt';

  @override
  String get save => 'Speichern';

  @override
  String get search => 'Suche';

  @override
  String get setting => 'Einstellung';

  @override
  String get language => 'Sprache';

  @override
  String get clearCache => 'Cache leeren';

  @override
  String get clear => 'leeren';

  @override
  String get cacheCleared => 'Cache erfolgreich geleert';

  @override
  String get setSteamPath => 'Steam-Pfad\nfestlegen';

  @override
  String get set => 'Setzen';

  @override
  String get steamPathSet => 'Steam Pfad erfolgreich festgelegt';

  @override
  String get checkUpdate => 'Update prüfen';

  @override
  String get check => 'Prüfen';

  @override
  String get supportMe => 'Unterstütze mich';

  @override
  String get ok => 'OK';

  @override
  String newVersion(Object latestVersion) {
    return '🔥 Neue Version $latestVersion verfügbar!';
  }

  @override
  String get upToDate => '🎉 Bereits aktuell';

  @override
  String get downloadLink => 'Download-Link:';

  @override
  String protonPathNotFound(Object protonPath) {
    return 'Proton-Pfad nicht gefunden.\n\nBitte stelle sicher, dass Proton installiert ist und das Spiel Proton verwendet.\n\nAktueller Pfad: $protonPath';
  }

  @override
  String trainerPathNotFound(Object trainerPath) {
    return 'Trainerpfad nicht gefunden.\n\nAktueller Pfad: $trainerPath';
  }

  @override
  String steamPathNotFound(Object defaultPath, Object steamPath) {
    return 'Steam Pfad nicht gefunden.\n\nDu kannst den Pfad in den Einstellungen angeben.\n\nAktueller Pfad: $steamPath\n\nStandardpfad: $defaultPath';
  }

  @override
  String gamePathNotFound(Object gamePath) {
    return 'Spielpfad nicht gefunden. Bitte stelle sicher, dass das Spiel installiert ist.\n\nStelle bei Nicht-Steam Spielen oder benutzerdefinierten Trainern sicher, dass das Spiel ausgeführt wird.\n\nAktueller Pfad: $gamePath';
  }

  @override
  String get customTrainerGamePathNotFound => 'Spiel nicht gefunden. \n\nStelle bei Nicht-Steam Spielen oder benutzerdefinierten Trainern sicher, dass das Spiel läuft.';

  @override
  String get launchFail => 'Start fehlgeschlagen';

  @override
  String get loadGames => 'Spiele laden';

  @override
  String get load => 'laden';

  @override
  String get gameLoaded => 'Spiele erfolgreich geladen';

  @override
  String libraryPathNotFound(Object libraryPath) {
    return 'Bibliothekspfad nicht gefunden.\n\nAktueller Pfad: $libraryPath';
  }
}
