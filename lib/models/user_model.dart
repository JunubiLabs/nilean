import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? name;
  final bool registrationComplete;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    required this.registrationComplete,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      uid: doc.id,
      email: data['email'],
      name: data['name'],
      registrationComplete: data['registrationComplete'] ?? false,
    );
  }
}
