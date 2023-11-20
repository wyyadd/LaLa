class Trainer {
  String versionName;
  String trainerUrl;

  Trainer({
    required this.versionName,
    required this.trainerUrl,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      versionName: json['version_name'] as String,
      trainerUrl: json['trainer_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version_name': versionName,
      'trainer_url': trainerUrl,
    };
  }
}

abstract class Game {
  String name;
  int appId;

  Game({required this.name, required this.appId});

  Map<String, dynamic> toJson();

  String get id {
    return '$appId:$name';
  }
}

class OnlineGame extends Game {
  String nameZh;
  String specialNotes;
  String coverImageUrl;
  String? selectedVersion;
  List<Trainer> trainers;

  OnlineGame({
    required super.name,
    required this.nameZh,
    required super.appId,
    required this.specialNotes,
    required this.coverImageUrl,
    this.selectedVersion,
    required this.trainers,
  });

  factory OnlineGame.fromJson(Map<String, dynamic> json) {
    List<dynamic> trainerList = json['trainers'];
    List<Trainer> trainers = [];
    for (var trainerJson in trainerList) {
      trainers.add(Trainer.fromJson(trainerJson));
    }

    return OnlineGame(
      name: json['name'] as String,
      nameZh: json['name_zh'] == null ? json['name'] : json['name_zh'] as String,
      appId: json['app_id'] as int,
      specialNotes: json['special_notes'] ?? '',
      coverImageUrl: json['cover_image_url'] as String,
      selectedVersion: json['selected_version'] as String?,
      trainers: trainers,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> trainerList = [];
    for (var trainer in trainers) {
      trainerList.add(trainer.toJson());
    }

    return {
      'name': name,
      'name_zh': nameZh,
      'app_id': appId,
      'special_notes': specialNotes,
      'cover_image_url': coverImageUrl,
      'selected_version': selectedVersion,
      'trainers': trainerList,
    };
  }
}

class CustomGame extends Game {
  String coverImagePath;
  String trainerPath;

  CustomGame({
    required super.name,
    required super.appId,
    required this.coverImagePath,
    required this.trainerPath,
  });

  factory CustomGame.fromJson(Map<String, dynamic> json) {
    return CustomGame(
      name: json['name'] as String,
      appId: json['app_id'] as int,
      coverImagePath: json['cover_image_path'] as String,
      trainerPath: json['trainer_path'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'app_id': appId,
      'cover_image_path': coverImagePath,
      'trainer_path': trainerPath,
    };
  }
}
