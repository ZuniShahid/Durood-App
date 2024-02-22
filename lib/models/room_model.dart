class RoomModel {
  final int? groupId;
  final String? groupName;
  final String? adminName;
  final String? allowedParticipants;
  final List<AddedParticipant>? addedParticipants;
  final int? addedParticipantsCount;
  final int? groupTarget;
  final int? completedTarget;

  RoomModel({
    this.groupId,
    this.groupName,
    this.adminName,
    this.allowedParticipants,
    this.addedParticipants,
    this.addedParticipantsCount,
    this.groupTarget,
    this.completedTarget,
  });

  RoomModel copyWith({
    int? groupId,
    String? groupName,
    String? adminName,
    String? allowedParticipants,
    List<AddedParticipant>? addedParticipants,
    int? addedParticipantsCount,
    int? groupTarget,
    int? completedTarget,
  }) {
    return RoomModel(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      adminName: adminName ?? this.adminName,
      allowedParticipants: allowedParticipants ?? this.allowedParticipants,
      addedParticipants: addedParticipants ?? this.addedParticipants,
      addedParticipantsCount: addedParticipantsCount ?? this.addedParticipantsCount,
      groupTarget: groupTarget ?? this.groupTarget,
      completedTarget: completedTarget ?? this.completedTarget,
    );
  }

  RoomModel incrementCompletedTarget() {
    return copyWith(completedTarget: (completedTarget ?? 0) + 1);
  }

  RoomModel setCompletedTarget(int newCompletedTarget) {
    return copyWith(completedTarget: newCompletedTarget);
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        groupId: json["group_id"],
        groupName: json["group_name"],
        adminName: json["admin_name"] ?? '',
        allowedParticipants: json["allowed_participants"] ?? '',
        addedParticipants: json["added_participants"] == null
            ? []
            : List<AddedParticipant>.from(json["added_participants"]!.map((x) => AddedParticipant.fromJson(x))),
        addedParticipantsCount: json["added_participants_count"] ?? 0,
        groupTarget: json["group_target"] ?? 0,
        completedTarget: json["completed_target"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
        "admin_name": adminName,
        "allowed_participants": allowedParticipants,
        "added_participants":
            addedParticipants == null ? [] : List<dynamic>.from(addedParticipants!.map((x) => x.toJson())),
        "added_participants_count": addedParticipantsCount,
        "group_target": groupTarget,
        "completed_target": completedTarget,
      };
}

class AddedParticipant {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? gender;
  final String? city;
  final String? phone;
  final int? verified;
  final String? otp;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imagePath;

  AddedParticipant({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.city,
    this.phone,
    this.verified,
    this.otp,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  factory AddedParticipant.fromJson(Map<String, dynamic> json) => AddedParticipant(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        gender: json["gender"],
        city: json["city"],
        phone: json["phone"],
        verified: json["verified"],
        otp: json["otp"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imagePath: json["image_path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "gender": gender,
        "city": city,
        "phone": phone,
        "verified": verified,
        "otp": otp,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_path": imagePath,
      };
}
