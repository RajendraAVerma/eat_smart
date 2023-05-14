import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String photoURL;
  final String phoneNumber;
  final String uid;
  final String disease;
  final int diseaseSeverity;
  final Timestamp timestamp;

  UserEntity({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.phoneNumber,
    required this.uid,
    required this.disease,
    required this.diseaseSeverity,
    required this.timestamp,
  });

  Map<String, Object> toJson() {
    return {
      'id': id,
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      id: json['id'] as String,
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoURL: json['photoURL'] as String,
      phoneNumber: json['phoneNumber'] as String,
      disease: json['disease'] as String,
      diseaseSeverity: json['diseaseSeverity'] as int,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      id: (snap.data() as Map<String, dynamic>)['id'] ?? "",
      uid: (snap.data() as Map<String, dynamic>)['uid'] ?? "",
      email: (snap.data() as Map<String, dynamic>)['email'] ?? "",
      displayName: (snap.data() as Map<String, dynamic>)['displayName'] ?? "",
      phoneNumber: (snap.data() as Map<String, dynamic>)['phoneNumber'] ?? "",
      photoURL: (snap.data() as Map<String, dynamic>)['photoURL'] ?? "",
      disease: (snap.data() as Map<String, dynamic>)['disease'] ?? "",
      diseaseSeverity:
          (snap.data() as Map<String, dynamic>)['diseaseSeverity'] ?? 0,
      timestamp: (snap.data() as Map<String, dynamic>)['timestamp'] ??
          Timestamp.fromDate(DateTime(1000)),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        displayName,
        email,
        photoURL,
        phoneNumber,
        disease,
        diseaseSeverity,
        timestamp,
      ];
}
