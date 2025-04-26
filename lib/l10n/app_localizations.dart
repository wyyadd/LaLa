import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'LaLa Trainer Launcher'**
  String get title;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// No description provided for @specialNotes.
  ///
  /// In en, this message translates to:
  /// **'Special Notes'**
  String get specialNotes;

  /// No description provided for @launch.
  ///
  /// In en, this message translates to:
  /// **'Launch'**
  String get launch;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Oops, no results found. Try different keywords!'**
  String get notFound;

  /// No description provided for @libraryEmpty.
  ///
  /// In en, this message translates to:
  /// **'The game library is empty.\nSearch and add your favorites!'**
  String get libraryEmpty;

  /// No description provided for @addTrainers.
  ///
  /// In en, this message translates to:
  /// **'Add Trainers'**
  String get addTrainers;

  /// No description provided for @gameName.
  ///
  /// In en, this message translates to:
  /// **'Game Name:'**
  String get gameName;

  /// No description provided for @trainerPath.
  ///
  /// In en, this message translates to:
  /// **'Trainer Path:'**
  String get trainerPath;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @gameCover.
  ///
  /// In en, this message translates to:
  /// **'Game Cover:\n(Optional)'**
  String get gameCover;

  /// No description provided for @trainerAdded.
  ///
  /// In en, this message translates to:
  /// **'Trainer added successfully'**
  String get trainerAdded;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheCleared;

  /// No description provided for @setSteamPath.
  ///
  /// In en, this message translates to:
  /// **'Set Steam Path'**
  String get setSteamPath;

  /// No description provided for @set.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// No description provided for @steamPathSet.
  ///
  /// In en, this message translates to:
  /// **'Steam path set successfully'**
  String get steamPathSet;

  /// No description provided for @checkUpdate.
  ///
  /// In en, this message translates to:
  /// **'Check Update'**
  String get checkUpdate;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @supportMe.
  ///
  /// In en, this message translates to:
  /// **'Support me'**
  String get supportMe;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @newVersion.
  ///
  /// In en, this message translates to:
  /// **'🔥 New Version {latestVersion} available!'**
  String newVersion(Object latestVersion);

  /// No description provided for @upToDate.
  ///
  /// In en, this message translates to:
  /// **'🎉 Already up to date'**
  String get upToDate;

  /// No description provided for @downloadLink.
  ///
  /// In en, this message translates to:
  /// **'Download Link:'**
  String get downloadLink;

  /// No description provided for @protonPathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Proton path not found.\n\nPlease ensure Proton is installed and the game uses Proton.\n\nCurrent Path: {protonPath}'**
  String protonPathNotFound(Object protonPath);

  /// No description provided for @trainerPathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Trainer path not found.\n\nCurrent Path: {trainerPath}'**
  String trainerPathNotFound(Object trainerPath);

  /// No description provided for @steamPathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Steam path not found.\n\nYou can specify the path in the settings.\n\nCurrent Path: {steamPath}\n\nDefault Path: {defaultPath}'**
  String steamPathNotFound(Object defaultPath, Object steamPath);

  /// No description provided for @gamePathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Game path not found. Please ensure the game is installed.\n\nFor non-Steam games or custom trainers, make sure the game is running.\n\nCurrent Path: {gamePath}'**
  String gamePathNotFound(Object gamePath);

  /// No description provided for @customTrainerGamePathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Game not found. \n\nFor non-Steam games or custom trainers, make sure the game is running.'**
  String get customTrainerGamePathNotFound;

  /// No description provided for @launchFail.
  ///
  /// In en, this message translates to:
  /// **'Launch failed'**
  String get launchFail;

  /// No description provided for @loadGames.
  ///
  /// In en, this message translates to:
  /// **'Load Games'**
  String get loadGames;

  /// No description provided for @load.
  ///
  /// In en, this message translates to:
  /// **'load'**
  String get load;

  /// No description provided for @gameLoaded.
  ///
  /// In en, this message translates to:
  /// **'Games loaded successfully'**
  String get gameLoaded;

  /// No description provided for @libraryPathNotFound.
  ///
  /// In en, this message translates to:
  /// **'Library path not found.\n\nCurrent Path: {libraryPath}'**
  String libraryPathNotFound(Object libraryPath);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
