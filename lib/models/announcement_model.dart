class AnnouncementsModelList {
  final int? id;
  final int? announcementId;
  final int? teamId;
  final int? userId;
  final int? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? title;
  final String? message;
  final String? visibility;
  final int? pinned;
  final AnnouncementDetailModel? announcementDetail;

  AnnouncementsModelList({
    this.id,
    this.announcementId,
    this.teamId,
    this.userId,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.message,
    this.visibility,
    this.pinned,
    this.announcementDetail,
  });

  factory AnnouncementsModelList.fromJson(Map<String, dynamic> json) =>
      AnnouncementsModelList(
        id: json["id"],
        announcementId: json["announcement_id"],
        teamId: json["team_id"],
        userId: json["user_id"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        title: json["title"],
        message: json["message"],
        visibility: json["visibility"],
        pinned: json["pinned"],
        announcementDetail: json["announcement"] == null
            ? null
            : AnnouncementDetailModel.fromJson(json["announcement"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "announcement_id": announcementId,
        "team_id": teamId,
        "user_id": userId,
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "title": title,
        "message": message,
        "visibility": visibility,
        "pinned": pinned,
        "announcement": announcementDetail?.toJson(),
      };
}

class AnnouncementDetailModel {
  final int? id;
  final int? userId;
  final String? title;
  final String? message;
  final String? visibility;
  final int? pinned;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userPhoto;
  final String? userName;
  final int? attachments;

  AnnouncementDetailModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.visibility,
    this.pinned,
    this.createdAt,
    this.updatedAt,
    this.userPhoto,
    this.userName,
    this.attachments,
  });

  factory AnnouncementDetailModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementDetailModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        message: json["message"] ?? '',
        visibility: json["visibility"],
        pinned: json["pinned"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userPhoto: json["user_photo"] ?? '',
        userName: json["user_name"] ?? '',
        attachments: json["attachments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "message": message,
        "visibility": visibility,
        "pinned": pinned,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_photo": userPhoto,
        "user_name": userName,
        "attachments": attachments,
      };
}
