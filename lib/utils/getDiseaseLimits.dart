import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_smart/utils/getDateId.dart';
import 'package:user_repository/user_repository.dart';

const disease_limits = {
  'Obesity': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 22.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 225.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 25.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Type 2 diabetes': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 15.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 130.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 25.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Cardiovascular disease': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 2.3,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.3,
    'Fatty acids, total saturated': 15.5,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 25.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'High blood pressure': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 16.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 21.5,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Osteoporosis': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.5,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Non-alcoholic fatty liver disease': {
    'Calcium': 0.6,
    'Iron': 0.0,
    'Sodium': 1.2,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 20.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 420.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 30.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Metabolic syndrome': {
    'Calcium': 0.6,
    'Iron': 0.017,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 30.0,
    'Protein': 60.0,
    'Carbohydrate, by difference': 555.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Gout': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.5,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 45.0,
    'Carbohydrate, by difference': 350,
    'Energy': 0.0,
    'Sugars, total including NLEA': 20.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Rheumatoid arthritis': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0,
    'Sugars, total including NLEA': 22.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Multiple sclerosis': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 15.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  "Crohn's disease": {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 20.0,
    'Protein': 40.0,
    'Carbohydrate, by difference': 260,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 23.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.4
  },
  'Hepatitis': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 23.4,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Gallbladder disease': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 21.5,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Kidney disease': {
    'Calcium': 1.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 48.75,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 3.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  "Alzheimer's disease": {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 32.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  "Parkinson's disease": {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 30.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Autism': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 23.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Acne': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 24.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Asthma': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.5,
    'VitaminA': 0.0,
    'VitaminC': 0.0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0.0,
    'Energy': 0.0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Respiratory infections': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.8,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Chronic fatigue syndrome': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 23.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Insomnia': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 3.5,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Premenstrual syndrome': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 4.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Polycystic ovary syndrome': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 325,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Erectile dysfunction': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 15.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 2.0,
    'Total lipid (fat)': 0.0
  },
  'Prostate cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 15.5,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 2.2,
    'Total lipid (fat)': 0.0
  },
  'Breast cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 20.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Lung cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 1.7,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 23.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Pancreatic cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 20.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Ovarian cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 22.22,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 2.1,
    'Total lipid (fat)': 0.0
  },
  'Endometrial cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 13.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Bladder cancer': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 21.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Kidney cancer': {
    'Calcium': 0.5,
    'Iron': 0.017,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 337,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 4.6,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Melanoma': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 30.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Liver cancer': {
    'Calcium': 0.0,
    'Iron': 10.0,
    'Sodium': 1.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 20.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 24.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'High cholesterol': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.2,
    'Fatty acids, total saturated': 13.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.1,
    'Total lipid (fat)': 0.3
  },
  'Diarrhea': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 0.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 20.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Shortness of breath': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 2.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 22.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 25.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'low blood pressure': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 21.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 20.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'Stomach cramps': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 44.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  },
  'nausea': {
    'Calcium': 0.0,
    'Iron': 0.0,
    'Sodium': 0.0,
    'VitaminA': 0,
    'VitaminC': 0,
    'Cholesterol': 0.0,
    'Fatty acids, total saturated': 16.0,
    'Protein': 0.0,
    'Carbohydrate, by difference': 0,
    'Energy': 0,
    'Sugars, total including NLEA': 0.0,
    'Fiber': 0.0,
    'Potassium': 0.0,
    'Fatty acids, total trans': 0.0,
    'Total lipid (fat)': 0.0
  }
};

const ingridients = [
  'Protein',
  'Carbohydrate, by difference',
  'Total lipid (fat)',
  'Sugars, total including NLEA',
  'Fatty acids, total trans',
  'Fatty acids, total saturated'
];

const severityMultiplier = {
  1: 2,
  2: 1.5,
  3: 1,
  4: 0.6,
  5: 0,
};

void calcDiseaseLimits(String diseaseName, int severity) {
  Map<String, double> disease_limit = {};
  for (var ingridient in ingridients) {
    disease_limit[ingridient] =
        (disease_limits[diseaseName]?[ingridient] as double) *
            (severityMultiplier[severity] ?? 0.0);
  }
}

DaywiseLimit getDaywiseLimit(String diseaseName, int severity) {
  return DaywiseLimit(
    id: getDateId(),
    protein:
        ((((disease_limits[diseaseName] ?? {})['Protein']) ?? 0.0) as double) *
            (severityMultiplier[severity] ?? 0.0),
    carbohydrate: ((((disease_limits[diseaseName] ??
                {})['Carbohydrate, by difference']) ??
            0.0) as double) *
        (severityMultiplier[severity] ?? 0.0),
    totalLipidFat:
        ((((disease_limits[diseaseName] ?? {})['Total lipid (fat)']) ?? 0.0)
                as double) *
            (severityMultiplier[severity] ?? 0.0),
    sugarsTotalIncludingNLEA: ((((disease_limits[diseaseName] ??
                {})['Sugars, total including NLEA']) ??
            0.0) as double) *
        (severityMultiplier[severity] ?? 0.0),
    fattyAcidsTotalTrans:
        ((((disease_limits[diseaseName] ?? {})['Fatty acids, total trans']) ??
                0.0) as double) *
            (severityMultiplier[severity] ?? 0.0),
    fattyAcidsTotalSaturated: ((((disease_limits[diseaseName] ??
                {})['Fatty acids, total saturated']) ??
            0.0) as double) *
        (severityMultiplier[severity] ?? 0.0),
    disease: diseaseName,
    diseaseSeverity: severity,
    timestamp: Timestamp.now(),
  );
}

DaywiseLimit getDaywiseLimitWithGivenFood({
  required String diseaseName,
  required int severity,
  required List<dynamic> foodNutrients,
  required DaywiseLimit currentLimits,
}) {
  if (currentLimits.isEmpty) {
    currentLimits = getDaywiseLimit(diseaseName, severity);
  }
  Map<String, double> foodNutritionValues = {};
  for (dynamic ingredient in foodNutrients) {
    double value =
        double.tryParse((ingredient['value'] ?? 0.0).toString()) ?? 0.0;
    foodNutritionValues[(ingredient['nutrientName'] ?? "") as String] = value;
    if ((ingredient['unitName'] ?? "") == 'MG') {
      foodNutritionValues[(ingredient['nutrientName'] ?? "") as String] =
          (foodNutritionValues[(ingredient['nutrientName'] ?? "") as String]
                  as double) /
              1000;
    }
  }
  return DaywiseLimit(
    id: getDateId(),
    protein: currentLimits.protein - (foodNutritionValues['Protein'] ?? 0.0),
    carbohydrate: currentLimits.carbohydrate -
        (foodNutritionValues['Carbohydrate, by difference'] ?? 0.0),
    totalLipidFat: currentLimits.totalLipidFat -
        (foodNutritionValues['Total lipid (fat)'] ?? 0.0),
    sugarsTotalIncludingNLEA: currentLimits.sugarsTotalIncludingNLEA -
        (foodNutritionValues['Sugars, total including NLEA'] ?? 0.0),
    fattyAcidsTotalTrans: currentLimits.fattyAcidsTotalTrans -
        (foodNutritionValues['Fatty acids, total trans'] ?? 0.0),
    fattyAcidsTotalSaturated: currentLimits.fattyAcidsTotalSaturated -
        (foodNutritionValues['Fatty acids, total saturated'] ?? 0.0),
    disease: diseaseName,
    diseaseSeverity: severity,
    timestamp: Timestamp.now(),
  );
}

DaywiseLimit getHarmingValues({
  required String diseaseName,
  required int severity,
  required List<dynamic> foodNutrients,
  required DaywiseLimit currentLimits,
}) {
  DaywiseLimit foodLimit = getDaywiseLimitWithGivenFood(
    diseaseName: diseaseName,
    severity: severity,
    foodNutrients: foodNutrients,
    currentLimits: currentLimits,
  );
  DaywiseLimit diseaseLimit = getDaywiseLimit(diseaseName, severity);

  return DaywiseLimit(
    id: getDateId(),
    protein: diseaseLimit.protein == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.protein - foodLimit.protein) /
                    diseaseLimit.protein) *
            100,
    carbohydrate: diseaseLimit.carbohydrate == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.carbohydrate - foodLimit.carbohydrate) /
                    diseaseLimit.carbohydrate) *
            100,
    totalLipidFat: diseaseLimit.totalLipidFat == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.totalLipidFat - foodLimit.totalLipidFat) /
                    diseaseLimit.totalLipidFat) *
            100,
    sugarsTotalIncludingNLEA: diseaseLimit.sugarsTotalIncludingNLEA == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.sugarsTotalIncludingNLEA -
                        foodLimit.sugarsTotalIncludingNLEA) /
                    diseaseLimit.sugarsTotalIncludingNLEA) *
            100,
    fattyAcidsTotalTrans: diseaseLimit.fattyAcidsTotalTrans == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.fattyAcidsTotalTrans -
                        foodLimit.fattyAcidsTotalTrans) /
                    diseaseLimit.fattyAcidsTotalTrans) *
            100,
    fattyAcidsTotalSaturated: diseaseLimit.fattyAcidsTotalSaturated == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.fattyAcidsTotalSaturated -
                        foodLimit.fattyAcidsTotalSaturated) /
                    diseaseLimit.fattyAcidsTotalSaturated) *
            100,
    disease: diseaseName,
    diseaseSeverity: severity,
    timestamp: Timestamp.now(),
  );
}

DaywiseLimit getDailyHarmingValues({
  required String diseaseName,
  required int severity,
  required DaywiseLimit currentLimit,
}) {
  DaywiseLimit diseaseLimit = getDaywiseLimit(diseaseName, severity);
  return DaywiseLimit(
    id: getDateId(),
    protein: diseaseLimit.protein == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.protein - currentLimit.protein) /
                    diseaseLimit.protein) *
            100,
    carbohydrate: diseaseLimit.carbohydrate == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.carbohydrate - currentLimit.carbohydrate) /
                    diseaseLimit.carbohydrate) *
            100,
    totalLipidFat: diseaseLimit.totalLipidFat == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.totalLipidFat - currentLimit.totalLipidFat) /
                    diseaseLimit.totalLipidFat) *
            100,
    sugarsTotalIncludingNLEA: diseaseLimit.sugarsTotalIncludingNLEA == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.sugarsTotalIncludingNLEA -
                        currentLimit.sugarsTotalIncludingNLEA) /
                    diseaseLimit.sugarsTotalIncludingNLEA) *
            100,
    fattyAcidsTotalTrans: diseaseLimit.fattyAcidsTotalTrans == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.fattyAcidsTotalTrans -
                        currentLimit.fattyAcidsTotalTrans) /
                    diseaseLimit.fattyAcidsTotalTrans) *
            100,
    fattyAcidsTotalSaturated: diseaseLimit.fattyAcidsTotalSaturated == 0.0
        ? 0.0
        : (1 -
                (diseaseLimit.fattyAcidsTotalSaturated -
                        currentLimit.fattyAcidsTotalSaturated) /
                    diseaseLimit.fattyAcidsTotalSaturated) *
            100,
    disease: diseaseName,
    diseaseSeverity: severity,
    timestamp: Timestamp.now(),
  );
}

String getDailyIndex({
  required String diseaseName,
  required int severity,
  required DaywiseLimit currentLimit,
}) {
  DaywiseLimit dailyLimit = getDailyHarmingValues(
    diseaseName: diseaseName,
    severity: severity,
    currentLimit: currentLimit,
  );
  return ((dailyLimit.protein +
              dailyLimit.carbohydrate +
              dailyLimit.totalLipidFat +
              dailyLimit.fattyAcidsTotalSaturated +
              dailyLimit.fattyAcidsTotalTrans) /
          2)
      .toStringAsFixed(2);
}
