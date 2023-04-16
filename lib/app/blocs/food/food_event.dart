part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends FoodEvent {
  XFile? xFile;
  final String path;

  PickImageEvent(this.xFile, this.path);
  @override
  List<Object> get props => [path];
}

class UploadImage extends FoodEvent {}

class SearchFoodNameList extends FoodEvent {}

class FetchFoods extends FoodEvent {
  final String name;
  FetchFoods(this.name);
  @override
  List<Object> get props => [name];
}

class ResetAll extends FoodEvent {}
