class VoiceModel {
  final Voice? voice;
  final List<Salawa>? salawaats;

  VoiceModel({
    this.voice,
    this.salawaats,
  });

  factory VoiceModel.fromJson(Map<String, dynamic> json) => VoiceModel(
        voice: json["voice"] == null ? null : Voice.fromJson(json["voice"]),
        salawaats: json["salawaats"] == null
            ? []
            : List<Salawa>.from(
                json["salawaats"]!.map((x) => Salawa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "voice": voice?.toJson(),
        "salawaats": salawaats == null
            ? []
            : List<dynamic>.from(salawaats!.map((x) => x.toJson())),
      };
}

class Salawa {
  final int? id;
  final String? voice;
  final String? audio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Salawa({
    this.id,
    this.voice,
    this.audio,
    this.createdAt,
    this.updatedAt,
  });

  factory Salawa.fromJson(Map<String, dynamic> json) => Salawa(
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
  final String? photo;
  final String? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Salawa>? salawats;

  Voice({
    this.id,
    this.name,
    this.photo,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.salawats,
  });

  factory Voice.fromJson(Map<String, dynamic> json) => Voice(
        id: json["id"],
        name: json["name"] ?? '',
        photo: json["photo"] ?? '',
        file: json["file"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        salawats: json["salawats"] == null
            ? []
            : List<Salawa>.from(
                json["salawats"]!.map((x) => Salawa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "salawats": salawats == null
            ? []
            : List<dynamic>.from(salawats!.map((x) => x.toJson())),
      };
}
