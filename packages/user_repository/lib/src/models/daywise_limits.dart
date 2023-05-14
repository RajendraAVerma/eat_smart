import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/entities/entities.dart';

class DaywiseLimit extends Equatable {
  final String id;
  final double protein;
  final double carbohydrate;
  final double totalLipidFat;
  final double sugarsTotalIncludingNLEA;
  final double fattyAcidsTotalTrans;
  final double fattyAcidsTotalSaturated;
  final String disease;
  final int diseaseSeverity;
  final Timestamp timestamp;

  DaywiseLimit({
    required this.id,
    required this.protein,
    required this.carbohydrate,
    required this.totalLipidFat,
    required this.sugarsTotalIncludingNLEA,
    required this.fattyAcidsTotalTrans,
    required this.fattyAcidsTotalSaturated,
    required this.disease,
    required this.diseaseSeverity,
    required this.timestamp,
  });

  DaywiseLimit copyWith({
    String? id,
    double? protein,
    double? carbohydrate,
    double? totalLipidFat,
    double? sugarsTotalIncludingNLEA,
    double? fattyAcidsTotalTrans,
    double? fattyAcidsTotalSaturated,
    String? disease,
    int? diseaseSeverity,
    Timestamp? timestamp,
  }) {
    return DaywiseLimit(
      id: id ?? this.id,
      protein: protein ?? this.protein,
      carbohydrate: carbohydrate ?? this.carbohydrate,
      totalLipidFat: totalLipidFat ?? this.totalLipidFat,
      sugarsTotalIncludingNLEA:
          sugarsTotalIncludingNLEA ?? this.sugarsTotalIncludingNLEA,
      fattyAcidsTotalTrans: fattyAcidsTotalTrans ?? this.fattyAcidsTotalTrans,
      fattyAcidsTotalSaturated:
          fattyAcidsTotalSaturated ?? this.fattyAcidsTotalSaturated,
      disease: disease ?? this.disease,
      diseaseSeverity: diseaseSeverity ?? this.diseaseSeverity,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  DaywiseLimitEntity toEntity() {
    return DaywiseLimitEntity(
      id: id,
      protein: protein,
      carbohydrate: carbohydrate,
      totalLipidFat: totalLipidFat,
      sugarsTotalIncludingNLEA: sugarsTotalIncludingNLEA,
      fattyAcidsTotalTrans: fattyAcidsTotalTrans,
      fattyAcidsTotalSaturated: fattyAcidsTotalSaturated,
      disease: disease,
      diseaseSeverity: diseaseSeverity,
      timestamp: timestamp,
    );
  }

  static DaywiseLimit fromEntity(DaywiseLimitEntity entity) {
    return DaywiseLimit(
      id: entity.id,
      protein: entity.protein,
      carbohydrate: entity.carbohydrate,
      totalLipidFat: entity.totalLipidFat,
      sugarsTotalIncludingNLEA: entity.sugarsTotalIncludingNLEA,
      fattyAcidsTotalTrans: entity.fattyAcidsTotalTrans,
      fattyAcidsTotalSaturated: entity.fattyAcidsTotalSaturated,
      disease: entity.disease,
      diseaseSeverity: entity.diseaseSeverity,
      timestamp: entity.timestamp,
    );
  }

  static DaywiseLimit empty = DaywiseLimit(
    id: "",
    protein: 0.0,
    carbohydrate: 0.0,
    totalLipidFat: 0.0,
    sugarsTotalIncludingNLEA: 0.0,
    fattyAcidsTotalTrans: 0.0,
    fattyAcidsTotalSaturated: 0.0,
    disease: "",
    diseaseSeverity: 0,
    timestamp: Timestamp.fromDate(DateTime(1000)),
  );

  bool get isEmpty => this == DaywiseLimit.empty;

  bool get isNotEmpty => this != DaywiseLimit.empty;

  @override
  List<Object?> get props => [
        id,
        protein,
        carbohydrate,
        totalLipidFat,
        sugarsTotalIncludingNLEA,
        fattyAcidsTotalTrans,
        fattyAcidsTotalSaturated,
        disease,
        diseaseSeverity,
        timestamp,
      ];
}
