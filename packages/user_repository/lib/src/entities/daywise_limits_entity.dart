import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaywiseLimitEntity extends Equatable {
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

  DaywiseLimitEntity({
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

  Map<String, Object> toJson() {
    return {
      'id': id,
      'protein': protein,
      'carbohydrate': carbohydrate,
      'totalLipidFat': totalLipidFat,
      'sugarsTotalIncludingNLEA': sugarsTotalIncludingNLEA,
      'fattyAcidsTotalTrans': fattyAcidsTotalTrans,
      'fattyAcidsTotalSaturated': fattyAcidsTotalSaturated,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

  static DaywiseLimitEntity fromJson(Map<String, Object> json) {
    return DaywiseLimitEntity(
      id: json['id'] as String,
      protein: json['protein'] as double,
      carbohydrate: json['carbohydrate'] as double,
      sugarsTotalIncludingNLEA: json['sugarsTotalIncludingNLEA'] as double,
      fattyAcidsTotalTrans: json['fattyAcidsTotalTrans'] as double,
      fattyAcidsTotalSaturated: json['fattyAcidsTotalSaturated'] as double,
      totalLipidFat: json['totalLipidFat'] as double,
      disease: json['disease'] as String,
      diseaseSeverity: json['diseaseSeverity'] as int,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  static DaywiseLimitEntity fromSnapshot(DocumentSnapshot snap) {
    return DaywiseLimitEntity(
      id: (snap.data() as Map<String, dynamic>)['id'] ?? "",
      protein: (snap.data() as Map<String, dynamic>)['protein'] ?? 0.0,
      carbohydrate:
          (snap.data() as Map<String, dynamic>)['carbohydrate'] ?? 0.0,
      totalLipidFat:
          (snap.data() as Map<String, dynamic>)['totalLipidFat'] ?? 0.0,
      sugarsTotalIncludingNLEA:
          (snap.data() as Map<String, dynamic>)['sugarsTotalIncludingNLEA'] ??
              0.0,
      fattyAcidsTotalTrans:
          (snap.data() as Map<String, dynamic>)['fattyAcidsTotalTrans'] ?? 0.0,
      fattyAcidsTotalSaturated:
          (snap.data() as Map<String, dynamic>)['fattyAcidsTotalSaturated'] ??
              0.0,
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
      'protein': protein,
      'carbohydrate': carbohydrate,
      'totalLipidFat': totalLipidFat,
      'sugarsTotalIncludingNLEA': sugarsTotalIncludingNLEA,
      'fattyAcidsTotalTrans': fattyAcidsTotalTrans,
      'fattyAcidsTotalSaturated': fattyAcidsTotalSaturated,
      'disease': disease,
      'diseaseSeverity': diseaseSeverity,
      'timestamp': timestamp,
    };
  }

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
