part of 'food_bloc.dart';

class FoodState extends Equatable {
  FoodState({
    required this.isLoading,
    required this.foodImageLink,
    required this.foodLabelsList,
    required this.pickedImage,
    required this.pickedImagePathname,
    required this.renderUI,
    required this.foods,
  });
  final bool isLoading;
  final String foodImageLink;
  XFile? pickedImage;
  final String pickedImagePathname;
  final List<String> foodLabelsList;
  final int renderUI;
  final List<Map<String, dynamic>> foods;

  FoodState copyWith({
    bool? isLoading,
    String? foodImageLink,
    List<String>? foodLabelsList,
    XFile? pickedImage,
    String? pickedImagePathname,
    int? renderUI,
    List<Map<String, dynamic>>? foods,
  }) {
    return FoodState(
      isLoading: isLoading ?? this.isLoading,
      foodImageLink: foodImageLink ?? this.foodImageLink,
      foodLabelsList: foodLabelsList ?? this.foodLabelsList,
      pickedImage: pickedImage ?? this.pickedImage,
      pickedImagePathname: pickedImagePathname ?? this.pickedImagePathname,
      renderUI: renderUI ?? this.renderUI,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        foodImageLink,
        foodLabelsList,
        renderUI,
        pickedImagePathname,
        foods,
      ];
}
