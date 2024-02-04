class VoiceModel {
  final int? id;
  final String? name;
  final String? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VoiceModel({
    this.id,
    this.name,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  factory VoiceModel.fromJson(Map<String, dynamic> json) => VoiceModel(
        id: json["id"],
        name: json["name"] ?? '',
        file: 'https://www.kozco.com/tech/organfinale.mp3',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
