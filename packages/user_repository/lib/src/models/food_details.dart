import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/entities/entities.dart';

class FoodDetails extends Equatable {
  final String id;
  final String foodName;
  final String foodLink;
  final String disease;
  final int diseaseSeverity;
  final Timestamp timestamp;

  FoodDetails({
    required this.id,
    required this.foodLink,
    required this.foodName,
    required this.disease,
    required this.diseaseSeverity,
    required this.timestamp,
  });

  FoodDetails copyWith({
    String? id,
    String? foodLink,
    String? foodName,
    String? disease,
    int? diseaseSeverity,
    Timestamp? timestamp,
  }) {
    return FoodDetails(
      id: id ?? this.id,
      foodLink: foodLink ?? this.foodLink,
      foodName: foodName ?? this.foodName,
      disease: disease ?? this.disease,
      diseaseSeverity: diseaseSeverity ?? this.diseaseSeverity,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  FoodDetailsEntity toEntity() {
    return FoodDetailsEntity(
      id: id,
      foodName: foodName,
      foodLink: foodLink,
      disease: disease,
      diseaseSeverity: diseaseSeverity,
      timestamp: timestamp,
    );
  }

  static FoodDetails fromEntity(FoodDetailsEntity entity) {
    return FoodDetails(
      id: entity.id,
      foodLink: entity.foodLink,
      foodName: entity.foodName,
      disease: entity.disease,
      diseaseSeverity: entity.diseaseSeverity,
      timestamp: entity.timestamp,
    );
  }

  static FoodDetails empty = FoodDetails(
    id: "",
    foodLink: "",
    foodName: "",
    disease: "",
    diseaseSeverity: 0,
    timestamp: Timestamp.fromDate(DateTime(1000)),
  );

  bool get isEmpty => this == FoodDetails.empty;

  bool get isNotEmpty => this != FoodDetails.empty;

  @override
  List<Object?> get props => [
        id,
        foodName,
        foodLink,
        disease,
        diseaseSeverity,
        timestamp,
      ];
}
