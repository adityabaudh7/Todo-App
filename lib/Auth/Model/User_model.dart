class UserModel {
  final String name;
  final String email;
  final String uid;
  final String phoneNumber;
  final String profilePic;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.phoneNumber,
    required this.profilePic,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'password': password
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        email: map['email'],
        uid: map['uid'],
        phoneNumber: map['phoneNumber'],
        profilePic: map['profilePic'],
        password: map['password']);
  }
}
