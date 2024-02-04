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
