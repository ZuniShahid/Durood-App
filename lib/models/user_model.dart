class UserModel {
  final String? accessToken;
  final String? refreshToken;
  final int? userId;
  final String? shortName;
  final String? fullName;
  final String? loginId;
  final String? profilePicture;
  final EmployementData? employementData;
  final ContactData? contactData;
  final String? role;
  final String? position;
  final LeaveData? leaveData;
  final String? team;
  final FinanceData? financeData;
  final DateTime? lastLoginAt;
  final int? lifetime;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? passportNumber;
  final DateTime? passportExpiryDate;
  final String? passportCopy;
  final String? gender;
  final String? race;
  final String? maritalStatus;
  final String? religion;

  UserModel({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.shortName,
    this.fullName,
    this.loginId,
    this.profilePicture,
    this.employementData,
    this.contactData,
    this.role,
    this.position,
    this.leaveData,
    this.team,
    this.financeData,
    this.lastLoginAt,
    this.lifetime,
    this.dateOfBirth,
    this.nationality,
    this.passportNumber,
    this.passportExpiryDate,
    this.passportCopy,
    this.gender,
    this.race,
    this.maritalStatus,
    this.religion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print("json[" "] ");
    print(json["leave_data"]);
    return UserModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      userId: json["userId"],
      shortName: json["short_name"],
      fullName: json["full_name"],
      loginId: json["login_id"],
      profilePicture: json["profile_picture"],
      employementData: json["employement_data"] == null
          ? null
          : EmployementData.fromJson(json["employement_data"]),
      contactData: json["contact_data"] == null
          ? null
          : ContactData.fromJson(json["contact_data"]),
      role: json["role"],
      position: json["position"],
      leaveData: json["leave_data"] == null
          ? null
          : LeaveData.fromJson(json["leave_data"]),
      team: json["team"],
      financeData: json["finance_data"] == null
          ? null
          : FinanceData.fromJson(json["finance_data"]),
      lastLoginAt: json["last_login_at"] == null
          ? null
          : DateTime.parse(json["last_login_at"]),
      lifetime: json["lifetime"],
      dateOfBirth: json["date_of_birth"] == null
          ? null
          : DateTime.parse(json["date_of_birth"]),
      nationality: json["nationality"],
      passportNumber: json["passport_number"],
      passportExpiryDate: json["passport_expiry_date"] == null
          ? null
          : DateTime.parse(json["passport_expiry_date"]),
      passportCopy: json["passport_copy"],
      gender: json["gender"],
      race: json["race"],
      maritalStatus: json["marital_status"],
      religion: json["religion"],
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken ?? '',
        "refreshToken": refreshToken ?? '',
        "userId": userId ?? '',
        "short_name": shortName ?? '',
        "full_name": fullName ?? '',
        "login_id": loginId ?? '',
        "profile_picture": profilePicture ?? '',
        "employement_data": employementData?.toJson(),
        "contact_data": contactData?.toJson(),
        "role": role ?? '',
        "position": position ?? '',
        "leave_data": leaveData?.toJson(),
        "team": team ?? '',
        "finance_data": financeData?.toJson(),
        "last_login_at": lastLoginAt?.toIso8601String(),
        "lifetime": lifetime ?? '',
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "nationality": nationality ?? '',
        "passport_number": passportNumber ?? '',
        "passport_expiry_date":
            "${passportExpiryDate!.year.toString().padLeft(4, '0')}-${passportExpiryDate!.month.toString().padLeft(2, '0')}-${passportExpiryDate!.day.toString().padLeft(2, '0')}",
        "passport_copy": passportCopy ?? '',
        "gender": gender ?? '',
        "race": race ?? '',
        "marital_status": maritalStatus ?? '',
        "religion": religion ?? '',
      };
}

class ContactData {
  final int? id;
  final int? userId;
  final String? phoneCode;
  final String? mobileNumber;
  final String? houseNumber;
  final String? email;
  final String? address;
  final String? city;
  final String? postcode;
  final String? country;
  final String? emergencyPerson;
  final String? emergencyRelation;
  final String? emergencyPhoneCode;
  final String? emergencyContact;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContactData({
    this.id,
    this.userId,
    this.phoneCode,
    this.mobileNumber,
    this.houseNumber,
    this.email,
    this.address,
    this.city,
    this.postcode,
    this.country,
    this.emergencyPerson,
    this.emergencyRelation,
    this.emergencyPhoneCode,
    this.emergencyContact,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
        id: json["id"],
        userId: json["user_id"],
        phoneCode: json["phone_code"],
        mobileNumber: json["mobile_number"],
        houseNumber: json["house_number"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        emergencyPerson: json["emergency_person"],
        emergencyRelation: json["emergency_relation"],
        emergencyPhoneCode: json["emergency_phone_code"],
        emergencyContact: json["emergency_contact"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "user_id": userId ?? '',
        "phone_code": phoneCode ?? '',
        "mobile_number": mobileNumber ?? '',
        "house_number": houseNumber ?? '',
        "email": email ?? '',
        "address": address ?? '',
        "city": city ?? '',
        "postcode": postcode ?? '',
        "country": country ?? '',
        "emergency_person": emergencyPerson ?? '',
        "emergency_relation": emergencyRelation ?? '',
        "emergency_phone_code": emergencyPhoneCode ?? '',
        "emergency_contact": emergencyContact ?? '',
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EmployementData {
  final int? id;
  final int? userId;
  final DateTime? dateJoined;
  final String? offerLetter;
  final int? rolePermission;
  final int? reportTo;
  final int? position;
  final String? positionGrade;
  final int? team;
  final int? workingHours;
  final String? workLocation;
  final String? branchOffice;
  final String? jobStatus;
  final String? jobType;
  final dynamic jobTypeStart;
  final dynamic jobTypeEnd;
  final dynamic jobTypeRemark;
  final String? workPermit;
  final String? visaNo;
  final DateTime? visaIssueDate;
  final DateTime? visaExpiredDate;
  final int? referral;
  final int? ownEmployee;
  final String? referralName;
  final int? referralByTeam;
  final String? referralContact;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EmployementData({
    this.id,
    this.userId,
    this.dateJoined,
    this.offerLetter,
    this.rolePermission,
    this.reportTo,
    this.position,
    this.positionGrade,
    this.team,
    this.workingHours,
    this.workLocation,
    this.branchOffice,
    this.jobStatus,
    this.jobType,
    this.jobTypeStart,
    this.jobTypeEnd,
    this.jobTypeRemark,
    this.workPermit,
    this.visaNo,
    this.visaIssueDate,
    this.visaExpiredDate,
    this.referral,
    this.ownEmployee,
    this.referralName,
    this.referralByTeam,
    this.referralContact,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployementData.fromJson(Map<String, dynamic> json) =>
      EmployementData(
        id: json["id"],
        userId: json["user_id"],
        dateJoined: json["date_joined"] == null
            ? null
            : DateTime.parse(json["date_joined"]),
        offerLetter: json["offer_letter"] ?? '',
        rolePermission: json["role_permission"] ?? '',
        reportTo: json["report_to"] ?? '',
        position: json["position"] ?? '',
        positionGrade: json["position_grade"] ?? '',
        team: json["team"] ?? '',
        workingHours: json["working_hours"] ?? '',
        workLocation: json["work_location"] ?? '',
        branchOffice: json["branch_office"] ?? '',
        jobStatus: json["job_status"] ?? '',
        jobType: json["job_type"] ?? '',
        jobTypeStart: json["job_type_start"] ?? '',
        jobTypeEnd: json["job_type_end"] ?? '',
        jobTypeRemark: json["job_type_remark"] ?? '',
        workPermit: json["work_permit"] ?? '',
        visaNo: json["visa_no"] ?? '',
        visaIssueDate: json["visa_issue_date"] == null
            ? null
            : DateTime.parse(json["visa_issue_date"]),
        visaExpiredDate: json["visa_expired_date"] == null
            ? null
            : DateTime.parse(json["visa_expired_date"]),
        referral: json["referral"] ?? '',
        ownEmployee: json["own_employee"] ?? '',
        referralName: json["referral_name"] ?? '',
        referralByTeam: json["referral_by_team"] ?? '',
        referralContact: json["referral_contact"] ?? '',
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
        "date_joined":
            "${dateJoined!.year.toString().padLeft(4, '0')}-${dateJoined!.month.toString().padLeft(2, '0')}-${dateJoined!.day.toString().padLeft(2, '0')}",
        "offer_letter": offerLetter ?? '',
        "role_permission": rolePermission ?? '',
        "report_to": reportTo ?? '',
        "position": position ?? '',
        "position_grade": positionGrade ?? '',
        "team": team ?? '',
        "working_hours": workingHours ?? '',
        "work_location": workLocation ?? '',
        "branch_office": branchOffice ?? '',
        "job_status": jobStatus ?? '',
        "job_type": jobType ?? '',
        "job_type_start": jobTypeStart ?? '',
        "job_type_end": jobTypeEnd ?? '',
        "job_type_remark": jobTypeRemark ?? '',
        "work_permit": workPermit ?? '',
        "visa_no": visaNo ?? '',
        "visa_issue_date":
            "${visaIssueDate!.year.toString().padLeft(4, '0')}-${visaIssueDate!.month.toString().padLeft(2, '0')}-${visaIssueDate!.day.toString().padLeft(2, '0')}",
        "visa_expired_date":
            "${visaExpiredDate!.year.toString().padLeft(4, '0')}-${visaExpiredDate!.month.toString().padLeft(2, '0')}-${visaExpiredDate!.day.toString().padLeft(2, '0')}",
        "referral": referral ?? '',
        "own_employee": ownEmployee ?? '',
        "referral_name": referralName ?? '',
        "referral_by_team": referralByTeam ?? '',
        "referral_contact": referralContact ?? '',
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class FinanceData {
  final int? id;
  final int? userId;
  final String? currency;
  final String? beneficiary;
  final String? bank;
  final String? accountNumber;
  final String? basicSalary;
  final String? kpiBonus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FinanceData({
    this.id,
    this.userId,
    this.currency,
    this.beneficiary,
    this.bank,
    this.accountNumber,
    this.basicSalary,
    this.kpiBonus,
    this.createdAt,
    this.updatedAt,
  });

  factory FinanceData.fromJson(Map<String, dynamic> json) => FinanceData(
        id: json["id"] ?? '',
        userId: json["user_id"] ?? '',
        currency: json["currency"] ?? '',
        beneficiary: json["beneficiary"] ?? '',
        bank: json["bank"] ?? '',
        accountNumber: json["account_number"] ?? '',
        basicSalary: json["basic_salary"] ?? '',
        kpiBonus: json["kpi_bonus"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "user_id": userId ?? '',
        "currency": currency ?? '',
        "beneficiary": beneficiary ?? '',
        "bank": bank ?? '',
        "account_number": accountNumber ?? '',
        "basic_salary": basicSalary ?? '',
        "kpi_bonus": kpiBonus ?? '',
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class LeaveData {
  final int? id;
  final int? userId;
  final String? restDay;
  final String? annualLeave;
  final String? alStartFrom;
  final String? alExpiredOn;
  final String? flightAllowanceCurrency;
  final String? flightAllowance;
  final String? eligibleStartFrom;
  final String? eligibleExpiredOn;
  final String? mealsAllowanceCurrency;
  final String? mealsAllowance;
  final String? medicalAllowanceCurrency;
  final String? medicalAllowance;
  final String? medicalEligibleStartFrom;
  final String? medicalEligibleExpiredOn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeaveData({
    this.id,
    this.userId,
    this.restDay,
    this.annualLeave,
    this.alStartFrom,
    this.alExpiredOn,
    this.flightAllowanceCurrency,
    this.flightAllowance,
    this.eligibleStartFrom,
    this.eligibleExpiredOn,
    this.mealsAllowanceCurrency,
    this.mealsAllowance,
    this.medicalAllowanceCurrency,
    this.medicalAllowance,
    this.medicalEligibleStartFrom,
    this.medicalEligibleExpiredOn,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) => LeaveData(
        id: json["id"],
        userId: json["user_id"],
        restDay: json["rest_day"] ?? '',
        annualLeave: json["annual_leave"] ?? '',
        alStartFrom: json["al_start_from"] ?? '',
        alExpiredOn: json["al_expired_on"] ?? '',
        flightAllowanceCurrency: json["flight_allowance_currency"] ?? '',
        flightAllowance: json["flight_allowance"] ?? '',
        eligibleStartFrom: json["eligible_start_from"] ?? '',
        eligibleExpiredOn: json["eligible_expired_on"] ?? '',
        mealsAllowanceCurrency: json["meals_allowance_currency"] ?? '',
        mealsAllowance: json["meals_allowance"] ?? '',
        medicalAllowanceCurrency: json["medical_allowance_currency"] ?? '',
        medicalAllowance: json["medical_allowance"] ?? '',
        medicalEligibleStartFrom: json["medical_eligible_start_from"] ?? '',
        medicalEligibleExpiredOn: json["medical_eligible_expired_on"] ?? '',
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
        "rest_day": restDay,
        "annual_leave": annualLeave,
        "al_start_from": alStartFrom,
        "al_expired_on": alExpiredOn,
        "flight_allowance_currency": flightAllowanceCurrency,
        "flight_allowance": flightAllowance,
        "eligible_start_from": eligibleStartFrom,
        "eligible_expired_on": eligibleExpiredOn,
        "meals_allowance_currency": mealsAllowanceCurrency,
        "meals_allowance": mealsAllowance,
        "medical_allowance_currency": medicalAllowanceCurrency,
        "medical_allowance": medicalAllowance,
        "medical_eligible_start_from": medicalEligibleStartFrom,
        "medical_eligible_expired_on": medicalEligibleExpiredOn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
