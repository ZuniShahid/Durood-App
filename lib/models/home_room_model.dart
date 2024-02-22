class HomeRoomModel {
  final int? id;
  final int? userId;
  final String? groupName;
  final String? adminName;
  final String? totalParticipants;
  final int? target;
  final int? targetCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomeRoomModel({
    this.id,
    this.userId,
    this.groupName,
    this.adminName,
    this.totalParticipants,
    this.target,
    this.targetCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeRoomModel.fromJson(Map<String, dynamic> json) => HomeRoomModel(
        id: json["id"],
        userId: json["user_id"],
        groupName: json["group_name"],
        adminName: json["admin_name"],
        totalParticipants: json["total_participants"],
        target: json["target"],
        targetCompleted: json["target_completed"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "group_name": groupName,
        "admin_name": adminName,
        "total_participants": totalParticipants,
        "target": target,
        "target_completed": targetCompleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class HomeVoiceModel {
  final Voice? voice;
  final List<Sal>? salwaats;

  HomeVoiceModel({
    this.voice,
    this.salwaats,
  });

  factory HomeVoiceModel.fromJson(Map<String, dynamic> json) => HomeVoiceModel(
        voice: json["voice"] == null ? null : Voice.fromJson(json["voice"]),
        salwaats: json["salwaats"] == null
            ? []
            : List<Sal>.from(json["salwaats"]!.map((x) => Sal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "voice": voice?.toJson(),
        "salwaats": salwaats == null
            ? []
            : List<dynamic>.from(salwaats!.map((x) => x.toJson())),
      };
}

class Sal {
  final int? id;
  final String? voice;
  final String? audio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Sal({
    this.id,
    this.voice,
    this.audio,
    this.createdAt,
    this.updatedAt,
  });

  factory Sal.fromJson(Map<String, dynamic> json) => Sal(
        id: json["id"],
        voice: json["voice"],
        audio: json["audio"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "voice": voice,
        "audio": audio,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Voice {
  final int? id;
  final String? name;
  final String? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Sal>? salawats;

  Voice({
    this.id,
    this.name,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.salawats,
  });

  factory Voice.fromJson(Map<String, dynamic> json) => Voice(
        id: json["id"],
        name: json["name"],
        file: json["file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        salawats: json["salawats"] == null
            ? []
            : List<Sal>.from(json["salawats"]!.map((x) => Sal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "salawats": salawats == null
            ? []
            : List<dynamic>.from(salawats!.map((x) => x.toJson())),
      };
}
