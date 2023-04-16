import 'dart:io';
import 'dart:typed_data';

import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/home/widgets/food_image.dart';
import 'package:eat_smart/app/home/widgets/foods_list_view.dart';
import 'package:eat_smart/app/home/widgets/labels_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SearchFoodBox extends StatelessWidget {
  const SearchFoodBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.isLoading) const CircularProgressIndicator(),
            const FoodImage(),
            // const LabelsListView(),
            const FoodListView(),
          ],
        );
      },
    );
  }
}
