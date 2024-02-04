class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? gender;
  final String? city;
  final String? phone;
  final int? verified;
  final String? otp;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        gender: json["gender"] ?? '',
        city: json["city"] ?? '',
        phone: json["phone"] ?? '',
        verified: json["verified"] ?? 1,
        otp: json["otp"] ?? '',
        image: json["image"] ?? '',
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
      };
}
