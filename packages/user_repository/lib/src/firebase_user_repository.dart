import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/food_details.dart';
import 'package:user_repository/src/models/daywise_limits.dart';
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

  @override
  Future<void> consumeFood({
    required String uid,
    required DaywiseLimit daywiseLimit,
    required FoodDetails foodDetails,
  }) async {
    await firestore
        .doc('users/$uid/daywise_limits/${daywiseLimit.id}')
        .set(daywiseLimit.toEntity().toDocument())
        .then((value) async {
      await firestore
          .doc(
              'users/$uid/daywise_limits/${daywiseLimit.id}/foods/${foodDetails.timestamp.toDate().toIso8601String()}')
          .set(foodDetails.toEntity().toDocument());
    });
  }

  @override
  Stream<List<FoodDetails>> getDayFoodList({
    required String uid,
    required String dayId,
  }) {
    return firestore
        .collection('users/$uid/daywise_limits/$dayId/foods')
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                FoodDetails.fromEntity(FoodDetailsEntity.fromSnapshot(e)))
            .toList());
  }

  @override
  Stream<DaywiseLimit> getDaywiseLimit({
    required String uid,
    required String dayId,
  }) {
    print(dayId);
    print(uid);
    return firestore
        .doc('users/$uid/daywise_limits/$dayId')
        .snapshots()
        .map((event) {
      if (event.exists) {
        return DaywiseLimit.fromEntity(DaywiseLimitEntity.fromSnapshot(event));
      } else {
        return DaywiseLimit.empty;
      }
    });
  }
}
