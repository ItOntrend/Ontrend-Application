class UserModel {
  String firstName;
  String lastName;
  String email;
  String adress;
  String country;
  String image;
  String timestamp;
  String role;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.adress,
    required this.country,
    required this.image,
    required this.timestamp,
    required this.role,
  });

  Map<String, dynamic> toMap () {
    return {
      'firstname': firstName,
      'lastName': lastName,
      'email': email,
      'country': country,
      'timestamp': timestamp,
      'image': image,
      'isApproved': lastName,
    };
  }
}
