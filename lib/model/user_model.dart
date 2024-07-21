class UserModel {
  String userId;
  String firstName;
  String lastName;
  String nationality;
  String number;
  String role;
  DateTime timeStamp;
  bool isEmailVerified;
  double rewardPoints; // New field

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.number,
    required this.role,
    required this.timeStamp,
    required this.isEmailVerified,
    required this.rewardPoints, // New field
  });

  UserModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? nationality,
    String? number,
    String? role,
    DateTime? timeStamp,
    bool? isEmailVerified,
    double? rewardPoints, // New field
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nationality: nationality ?? this.nationality,
        number: number ?? this.number,
        role: role ?? this.role,
        timeStamp: timeStamp ?? this.timeStamp,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        rewardPoints: rewardPoints ?? this.rewardPoints, // New field
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        nationality: json["nationality"],
        number: json["number"],
        role: json["role"],
        timeStamp: json["timeStamp"].toDate(),
        isEmailVerified: json["isEmailVerified"],
        rewardPoints: json["rewardPoints"]?.toDouble() ?? 0.0, // New field
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "nationality": nationality,
        "number": number,
        "role": role,
        "timeStamp": timeStamp,
        "isEmailVerified": isEmailVerified,
        "rewardPoints": rewardPoints, // New field
      };
}
