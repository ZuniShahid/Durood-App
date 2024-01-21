class NotebooksListModel {
  final int? id;
  final int? userId;
  final int? attentionTo;
  final String? title;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userPhoto;
  final String? userName;
  final String? attentionToUsername;

  NotebooksListModel({
    this.id,
    this.userId,
    this.attentionTo,
    this.title,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.userPhoto,
    this.userName,
    this.attentionToUsername,
  });

  factory NotebooksListModel.fromJson(Map<String, dynamic> json) =>
      NotebooksListModel(
        id: json["id"],
        userId: json["user_id"],
        attentionTo: json["attention_to"],
        title: json["title"],
        message: json["message"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userPhoto: json["user_photo"],
        userName: json["user_name"],
        attentionToUsername: json["attention_to_username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "attention_to": attentionTo,
        "title": title,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_photo": userPhoto,
        "user_name": userName,
        "attention_to_username": attentionToUsername,
      };
}
