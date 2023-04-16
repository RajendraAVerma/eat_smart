import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/entities/entities.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String photoURL;
  final String phoneNumber;
  final String uid;
  final Timestamp timestamp;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.phoneNumber,
    required this.uid,
    required this.timestamp,
  });

  User copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoURL,
    String? phoneNumber,
    String? uid,
    Timestamp? timestamp,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      displayName: displayName,
      email: email,
      photoURL: photoURL,
      phoneNumber: phoneNumber,
      uid: uid,
      timestamp: timestamp,
    );
  }

  static User fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      displayName: entity.displayName,
      email: entity.email,
      photoURL: entity.photoURL,
      phoneNumber: entity.phoneNumber,
      uid: entity.uid,
      timestamp: entity.timestamp,
    );
  }

  static User empty = User(
    id: "",
    displayName: "",
    email: "",
    photoURL: "",
    phoneNumber: "",
    uid: "",
    timestamp: Timestamp.fromDate(DateTime(1000)),
  );

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        id,
        displayName,
        email,
        photoURL,
        phoneNumber,
        uid,
        timestamp,
      ];
}
