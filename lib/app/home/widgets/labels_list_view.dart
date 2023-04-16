import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabelsListView extends StatelessWidget {
  const LabelsListView({
    super.key,
    required this.foodLabelsList,
    required this.onTap,
  });
  final List<String> foodLabelsList;
  final void Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: foodLabelsList.length,
              itemBuilder: (context, index) {
                String label = foodLabelsList[index];
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      child: Center(child: Text(label)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
