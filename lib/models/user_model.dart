import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final bool registrationComplete;

  @HiveField(4)
  final bool isEmailVerified;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    required this.registrationComplete,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      registrationComplete: json['registrationComplete'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'registrationComplete': registrationComplete,
      'isEmailVerified': isEmailVerified,
    };
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, name: $name, registrationComplete: $registrationComplete, isEmailVerified: $isEmailVerified}';
  }
}
