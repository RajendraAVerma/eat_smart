import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseUserRepository extends UserRepository {
  final firestore = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late final collection = FirebaseFirestore.instance.collection("users");

  @override
  Future<void> setUser(User user) async {
    await collection.doc(user.id).set(user.toEntity().toDocument());
  }

  @override
  Stream<User> userStream(String uid) {
    return collection.doc(uid).snapshots().map((event) {
      if (event.exists) {
        return User.fromEntity(UserEntity.fromSnapshot(event));
      } else {
        return User.empty;
      }
    });
  }

  @override
  Future<String> uploadImageAndGetLink(String uid, XFile xFile) async {
    String link = "";

    firebase_storage.Reference reference =
        storage.ref().child('users/$uid/foods/${xFile.name}');

    firebase_storage.UploadTask task;

    task = reference.putFile(
      File(xFile.path),
      firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
    );

    await task.then((taskSnapshot) async {
      link = await reference.getDownloadURL();
    });

    return link;
  }
}
