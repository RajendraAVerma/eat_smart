import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/home/widgets/chat_gpt_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListView extends StatelessWidget {
  const FoodListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state.foods.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> food = state.foods[index];
                return FoodCard(food: food);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  const FoodCard({super.key, required this.food});
  final Map<String, dynamic> food;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool isSeleted = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSeleted = !isSeleted;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColorLight.withOpacity(0.3),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.food['description'].toString()),
              if (isSeleted)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final initialQuestion =
                            'I am eating ${widget.food['description'].toString()}. Give me only its food Nutrients? Dont explain.';
                        await ChatGPTBox.show(context, initialQuestion);
                      },
                      child: const Text("Suggestion"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.food['foodNutrients'].length as int,
                      itemBuilder: (context, index) {
                        final nutrie = widget.food['foodNutrients'][index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(nutrie['nutrientName'].toString()),
                            Text(
                                '${nutrie['value'].toString()} ${nutrie['unitName'].toString()}'),
                          ],
                        );
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
