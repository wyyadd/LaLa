// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get title => 'LaLa 启动器';

  @override
  String get library => '库';

  @override
  String get game => '游戏';

  @override
  String get specialNotes => '特别提醒';

  @override
  String get launch => '启动';

  @override
  String get notFound => '抱歉，没有找到相关结果。试试其他关键词吧！';

  @override
  String get libraryEmpty => '游戏库为空，\n搜索并添加您喜欢的游戏吧！';

  @override
  String get addTrainers => '添加修改器';

  @override
  String get gameName => '游戏名称:';

  @override
  String get trainerPath => '修改器路径:';

  @override
  String get select => '选择';

  @override
  String get gameCover => '游戏封面:\n(可选)';

  @override
  String get trainerAdded => '修改器添加成功';

  @override
  String get save => '保存';

  @override
  String get search => '搜索';

  @override
  String get setting => '设置';

  @override
  String get language => '语言';

  @override
  String get clearCache => '清理缓存';

  @override
  String get clear => '清理';

  @override
  String get cacheCleared => '清理完成';

  @override
  String get setSteamPath => '设置Steam路径';

  @override
  String get set => '设置';

  @override
  String get steamPathSet => 'Steam路径设置成功';

  @override
  String get checkUpdate => '检查更新';

  @override
  String get check => '检查';

  @override
  String get supportMe => '支持我';

  @override
  String get ok => '确定';

  @override
  String newVersion(Object latestVersion) {
    return '🔥 新版本 $latestVersion 可更新！';
  }

  @override
  String get upToDate => '🎉 已是最新版本';

  @override
  String get downloadLink => '下载地址:';

  @override
  String protonPathNotFound(Object protonPath) {
    return '未找到Proton路径。\n\n请确认已安装Proton并且游戏使用proton。\n\n当前路径为: $protonPath';
  }

  @override
  String trainerPathNotFound(Object trainerPath) {
    return '未找到修改器路径。\n\n当前路径为: $trainerPath';
  }

  @override
  String steamPathNotFound(Object defaultPath, Object steamPath) {
    return '未找到Steam路径下的steamapps文件夹。\n\n您可以在设置中指定路径。\n\n当前路径为: $steamPath\n\n默认路径为: $defaultPath';
  }

  @override
  String gamePathNotFound(Object gamePath) {
    return '游戏路径未找到。请确保游戏已安装。\n\n对于非Steam游戏或者自定义修改器，请确保游戏已启动。\n\n当前路径为: $gamePath';
  }

  @override
  String get customTrainerGamePathNotFound => '游戏未找到。\n\n对于非Steam游戏或者自定义修改器，请确保游戏已启动。';

  @override
  String get launchFail => '启动失败';

  @override
  String get loadGames => '载入游戏';

  @override
  String get load => '载入';

  @override
  String get gameLoaded => '游戏载入成功';

  @override
  String libraryPathNotFound(Object libraryPath) {
    return '未找到游戏库路径。\n\n当前路径: $libraryPath';
  }

  @override
  String get setGameSteamPath => '设置游戏Steam路径';

  @override
  String get gameSteamPathSet => '游戏Steam路径设置成功';
}
