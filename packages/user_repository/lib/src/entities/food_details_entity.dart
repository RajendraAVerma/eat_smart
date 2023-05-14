import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodDetailsEntity extends Equatable {
  final String id;
  final String foodName;
  final String foodLink;
  final String disease;
  final int diseaseSeverity;
  final Timestamp timestamp;

  FoodDetailsEntity({
    required this.id,
    required this.foodLink,
    required this.foodName,
    required this.disease,
    required this.diseaseSeverity,
    required this.timestamp,
  });

  Map<String, Object> toJson() {
    return {
      'id': id,
      'foodLink': foodLink,
      'foodName': foodName,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

  static FoodDetailsEntity fromJson(Map<String, Object> json) {
    return FoodDetailsEntity(
      id: json['id'] as String,
      foodName: json['foodName'] as String,
      foodLink: json['foodLink'] as String,
      disease: json['disease'] as String,
      diseaseSeverity: json['diseaseSeverity'] as int,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  static FoodDetailsEntity fromSnapshot(DocumentSnapshot snap) {
    return FoodDetailsEntity(
      id: (snap.data() as Map<String, dynamic>)['id'] ?? "",
      foodLink: (snap.data() as Map<String, dynamic>)['foodLink'] ?? "",
      foodName: (snap.data() as Map<String, dynamic>)['foodName'] ?? "",
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
      'foodName': foodName,
      'foodLink': foodLink,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        id,
        foodLink,
        foodName,
        disease,
        diseaseSeverity,
        timestamp,
      ];
}
