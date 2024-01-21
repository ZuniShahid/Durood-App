class PaySlipModelList {
  final int? id;
  final int? userId;
  final String? month;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? currency;
  final String? basicSalary;
  final String? overTime;
  final String? overTimeRemark;
  final String? overTimeRemarkTwo;
  final String? restDayOverTime;
  final String? restDayRemark;
  final String? restDayRemarkTwo;
  final String? newYearOverTime;
  final String? newYearRemark;
  final String? newYearRemarkTwo;
  final String? kpiBonus;
  final String? foodAllowance;
  final String? nightShift;
  final String? insurance;
  final String? totalIncome;
  final String? holdBasicSalary;
  final String? holdBasicSalaryRemark;
  final String? unpaidLeave;
  final String? unpaidLeaveRemark;
  final String? salaryAdvance;
  final String? mistake;
  final String? mistakeRemark;
  final String? penalty;
  final String? penaltyRemark;
  final String? totalDeducation;
  final String? netSalary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final String? team;

  PaySlipModelList({
    this.id,
    this.userId,
    this.month,
    this.firstDate,
    this.lastDate,
    this.currency,
    this.basicSalary,
    this.overTime,
    this.overTimeRemark,
    this.overTimeRemarkTwo,
    this.restDayOverTime,
    this.restDayRemark,
    this.restDayRemarkTwo,
    this.newYearOverTime,
    this.newYearRemark,
    this.newYearRemarkTwo,
    this.kpiBonus,
    this.foodAllowance,
    this.nightShift,
    this.insurance,
    this.totalIncome,
    this.holdBasicSalary,
    this.holdBasicSalaryRemark,
    this.unpaidLeave,
    this.unpaidLeaveRemark,
    this.salaryAdvance,
    this.mistake,
    this.mistakeRemark,
    this.penalty,
    this.penaltyRemark,
    this.totalDeducation,
    this.netSalary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.team,
  });

  factory PaySlipModelList.fromJson(Map<String, dynamic> json) =>
      PaySlipModelList(
        id: json["id"],
        userId: json["user_id"],
        month: json["month"],
        firstDate: json["first_date"] == null
            ? null
            : DateTime.parse(json["first_date"]),
        lastDate: json["last_date"] == null
            ? null
            : DateTime.parse(json["last_date"]),
        currency: json["currency"],
        basicSalary: json["basic_salary"],
        overTime: json["over_time"],
        overTimeRemark: json["over_time_remark"],
        overTimeRemarkTwo: json["over_time_remark_two"],
        restDayOverTime: json["rest_day_over_time"],
        restDayRemark: json["rest_day_remark"],
        restDayRemarkTwo: json["rest_day_remark_two"],
        newYearOverTime: json["new_year_over_time"],
        newYearRemark: json["new_year_remark"],
        newYearRemarkTwo: json["new_year_remark_two"],
        kpiBonus: json["kpi_bonus"],
        foodAllowance: json["food_allowance"],
        nightShift: json["night_shift"],
        insurance: json["insurance"],
        totalIncome: json["total_income"],
        holdBasicSalary: json["hold_basic_salary"],
        holdBasicSalaryRemark: json["hold_basic_salary_remark"],
        unpaidLeave: json["unpaid_leave"],
        unpaidLeaveRemark: json["unpaid_leave_remark"],
        salaryAdvance: json["salary_advance"],
        mistake: json["mistake"],
        mistakeRemark: json["mistake_remark"],
        penalty: json["penalty"],
        penaltyRemark: json["penalty_remark"],
        totalDeducation: json["total_deducation"],
        netSalary: json["net_salary"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        team: json["team"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "month": month,
        "first_date":
            "${firstDate!.year.toString().padLeft(4, '0')}-${firstDate!.month.toString().padLeft(2, '0')}-${firstDate!.day.toString().padLeft(2, '0')}",
        "last_date":
            "${lastDate!.year.toString().padLeft(4, '0')}-${lastDate!.month.toString().padLeft(2, '0')}-${lastDate!.day.toString().padLeft(2, '0')}",
        "currency": currency,
        "basic_salary": basicSalary,
        "over_time": overTime,
        "over_time_remark": overTimeRemark,
        "over_time_remark_two": overTimeRemarkTwo,
        "rest_day_over_time": restDayOverTime,
        "rest_day_remark": restDayRemark,
        "rest_day_remark_two": restDayRemarkTwo,
        "new_year_over_time": newYearOverTime,
        "new_year_remark": newYearRemark,
        "new_year_remark_two": newYearRemarkTwo,
        "kpi_bonus": kpiBonus,
        "food_allowance": foodAllowance,
        "night_shift": nightShift,
        "insurance": insurance,
        "total_income": totalIncome,
        "hold_basic_salary": holdBasicSalary,
        "hold_basic_salary_remark": holdBasicSalaryRemark,
        "unpaid_leave": unpaidLeave,
        "unpaid_leave_remark": unpaidLeaveRemark,
        "salary_advance": salaryAdvance,
        "mistake": mistake,
        "mistake_remark": mistakeRemark,
        "penalty": penalty,
        "penalty_remark": penaltyRemark,
        "total_deducation": totalDeducation,
        "net_salary": netSalary,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "team": team,
      };
}

class User {
  final int? id;
  final String? fullName;
  final String? shortName;
  final String? loginId;
  final String? nationality;
  final String? employeeId;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? race;
  final String? religion;
  final String? maritalStatus;
  final String? icNum;
  final String? icCopy;
  final DateTime? pptExpired;
  final String? pptCopy;
  final String? photo;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.fullName,
    this.shortName,
    this.loginId,
    this.nationality,
    this.employeeId,
    this.gender,
    this.dateOfBirth,
    this.race,
    this.religion,
    this.maritalStatus,
    this.icNum,
    this.icCopy,
    this.pptExpired,
    this.pptCopy,
    this.photo,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        shortName: json["short_name"],
        loginId: json["login_id"],
        nationality: json["nationality"],
        employeeId: json["employee_id"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        race: json["race"],
        religion: json["religion"],
        maritalStatus: json["marital_status"],
        icNum: json["ic_num"],
        icCopy: json["ic_copy"],
        pptExpired: json["ppt_expired"] == null
            ? null
            : DateTime.parse(json["ppt_expired"]),
        pptCopy: json["ppt_copy"],
        photo: json["photo"],
        lastLoginAt: json["last_login_at"] == null
            ? null
            : DateTime.parse(json["last_login_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "short_name": shortName,
        "login_id": loginId,
        "nationality": nationality,
        "employee_id": employeeId,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "race": race,
        "religion": religion,
        "marital_status": maritalStatus,
        "ic_num": icNum,
        "ic_copy": icCopy,
        "ppt_expired":
            "${pptExpired!.year.toString().padLeft(4, '0')}-${pptExpired!.month.toString().padLeft(2, '0')}-${pptExpired!.day.toString().padLeft(2, '0')}",
        "ppt_copy": pptCopy,
        "photo": photo,
        "last_login_at": lastLoginAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
