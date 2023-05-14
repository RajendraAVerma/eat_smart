import 'dart:async';
import 'dart:typed_data';

import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:eat_smart/app/home/widgets/labels_list_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  UserRepository userRepository = FirebaseUserRepository();
  ApiRepository apiRepository = ApiV1Repository();
  final String uid;
  final BuildContext context;
  FoodBloc({required this.uid, required this.context})
      : super(
          FoodState(
            isLoading: false,
            foodImageLink: "",
            foodLabelsList: [],
            renderUI: 0,
            pickedImagePathname: "",
            pickedImage: null,
            foods: [],
          ),
        ) {
    on<UploadImage>(_onUploadImage);
    on<PickImageEvent>(_onPickedImage);
    on<SearchFoodNameList>(_onSeachFoodNameList);
    on<FetchFoods>(_onFetchFoods);
    on<ResetAll>(_onResetAll);
  }

  FutureOr<void> _onPickedImage(
    PickImageEvent event,
    Emitter<FoodState> emit,
  ) {
    print(event.xFile);
    emit(state.copyWith(
      pickedImage: event.xFile,
      renderUI: state.renderUI + 1,
      pickedImagePathname: event.path,
    ));
    add(UploadImage());
  }

  FutureOr<void> _onUploadImage(
    UploadImage event,
    Emitter<FoodState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final link =
        await userRepository.uploadImageAndGetLink(uid, state.pickedImage!);
    emit(state.copyWith(foodImageLink: link));
    add(SearchFoodNameList());
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onSeachFoodNameList(
    SearchFoodNameList event,
    Emitter<FoodState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final list =
        await apiRepository.getLabelsFromImageLink(state.foodImageLink);
    emit(state.copyWith(foodLabelsList: list));
    if (list.isNotEmpty) {
      add(FetchFoods(list[0]));
      print('fetched ??????????');
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              String label = list[index];
              return ListTile(
                onTap: () {
                  add(FetchFoods(label));
                  Navigator.of(context, rootNavigator: true).pop();
                  context.go('/result');
                },
                title: Center(child: Text(label)),
              );
            },
          ),
        );
      },
    );
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onFetchFoods(
    FetchFoods event,
    Emitter<FoodState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final list = await apiRepository.searchFoodFromName(event.name)
        as List<Map<String, dynamic>>;
    emit(state.copyWith(foods: list));
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onResetAll(
    ResetAll event,
    Emitter<FoodState> emit,
  ) {
    emit(state.copyWith(
      isLoading: false,
      foodImageLink: "",
      foodLabelsList: [],
      foods: [],
      pickedImage: null,
      pickedImagePathname: "",
      renderUI: 0,
    ));
  }
}
