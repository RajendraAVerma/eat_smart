import 'dart:io';

import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FoodImage extends StatelessWidget {
  const FoodImage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> getImage() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null)
        context
            .read<FoodBloc>()
            .add(PickImageEvent(pickedImage, pickedImage.path));
    }

    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state.pickedImagePathname != "") {
          return Container(
            height: 300,
            padding: const EdgeInsets.all(10),
            child: Image.file(
              File(state.pickedImagePathname),
            ),
          );
        } else if (state.foodImageLink != "") {
          return Image.network(state.foodImageLink);
        }
        return Container();
      },
    );
  }
}
