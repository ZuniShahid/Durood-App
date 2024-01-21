class LeaveListModel {
  final int? id;
  final int? userId;
  final String? fromTime;
  final String? toTime;
  final String? nationality;
  final String? leaveType;
  final String? reason;
  final String? status;
  final dynamic actionBy;
  final dynamic actionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? actionByName;
  final int? duration;

  LeaveListModel({
    this.id,
    this.userId,
    this.fromTime,
    this.toTime,
    this.nationality,
    this.leaveType,
    this.reason,
    this.status,
    this.actionBy,
    this.actionDate,
    this.createdAt,
    this.updatedAt,
    this.actionByName,
    this.duration,
  });

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
        id: json["id"],
        userId: json["user_id"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        nationality: json["nationality"],
        leaveType: json["leave_type"],
        reason: json["reason"],
        status: json["status"],
        actionBy: json["action_by"],
        actionDate: json["action_date"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        actionByName: json["action_by_name"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "from_time": fromTime,
        "to_time": toTime,
        "nationality": nationality,
        "leave_type": leaveType,
        "reason": reason,
        "status": status,
        "action_by": actionBy,
        "action_date": actionDate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "action_by_name": actionByName,
        "duration": duration,
      };
}
