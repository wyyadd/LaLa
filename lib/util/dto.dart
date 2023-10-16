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

class Game {
  String name;
  int appId;
  String coverImageUrl;
  String? selectedVersion;
  List<Trainer> trainers;

  Game({
    required this.name,
    required this.appId,
    required this.coverImageUrl,
    this.selectedVersion,
    required this.trainers,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    List<dynamic> trainerList = json['trainers'];
    List<Trainer> trainers = [];
    for (var trainerJson in trainerList) {
      trainers.add(Trainer.fromJson(trainerJson));
    }

    return Game(
      name: json['name'] as String,
      appId: json['app_id'] as int,
      coverImageUrl: json['cover_image_url'] as String,
      selectedVersion: json['selected_version'] as String?,
      trainers: trainers,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> trainerList = [];
    for (var trainer in trainers) {
      trainerList.add(trainer.toJson());
    }

    return {
      'name': name,
      'app_id': appId,
      'cover_image_url': coverImageUrl,
      'selected_version': selectedVersion,
      'trainers': trainerList,
    };
  }
}
