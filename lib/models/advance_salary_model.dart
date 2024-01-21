class AdvanceSalaryModel {
  final int? id;
  final int? userId;
  final DateTime? date;
  final String? amount;
  final String? currency;
  final String? reason;
  final String? status;
  final int? actionBy;
  final DateTime? actionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? actionByName;

  AdvanceSalaryModel({
    this.id,
    this.userId,
    this.date,
    this.amount,
    this.currency,
    this.reason,
    this.status,
    this.actionBy,
    this.actionDate,
    this.createdAt,
    this.updatedAt,
    this.actionByName,
  });

  factory AdvanceSalaryModel.fromJson(Map<String, dynamic> json) =>
      AdvanceSalaryModel(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        amount: json["amount"],
        currency: json["currency"],
        reason: json["reason"],
        status: json["status"],
        actionBy: json["action_by"],
        actionDate: json["action_date"] == null
            ? null
            : DateTime.parse(json["action_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        actionByName: json["action_by_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "currency": currency,
        "reason": reason,
        "status": status,
        "action_by": actionBy,
        "action_date":
            "${actionDate!.year.toString().padLeft(4, '0')}-${actionDate!.month.toString().padLeft(2, '0')}-${actionDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "action_by_name": actionByName,
      };
}
