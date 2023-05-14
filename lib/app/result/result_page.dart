import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/blocs/user/user_bloc.dart';
import 'package:eat_smart/utils/getDateId.dart';
import 'package:eat_smart/utils/getDiseaseLimits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class ResultPage extends StatelessWidget {
  const ResultPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: StreamBuilder<DaywiseLimit>(
          stream: FirebaseUserRepository().getDaywiseLimit(
            uid: context.read<UserBloc>().uid,
            dayId: getDateId(),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  final currentLimit = snapshot.data!;
                  final foodHarmingValues = getHarmingValues(
                    diseaseName: context.read<UserBloc>().state.user.disease,
                    severity:
                        context.read<UserBloc>().state.user.diseaseSeverity,
                    foodNutrients: (state.foods[0]['foodNutrients'] ?? [])
                        as List<dynamic>,
                    currentLimits: currentLimit.isEmpty
                        ? DaywiseLimit.empty
                        : currentLimit,
                  );
                  final foodLimitValues = getDaywiseLimitWithGivenFood(
                    diseaseName: context.read<UserBloc>().state.user.disease,
                    severity:
                        context.read<UserBloc>().state.user.diseaseSeverity,
                    foodNutrients: (context.read<FoodBloc>().state.foods[0]
                            ['foodNutrients'] ??
                        []) as List<dynamic>,
                    currentLimits: currentLimit.isEmpty
                        ? DaywiseLimit.empty
                        : currentLimit,
                  );
                  final Map<String, double> harmingValues = {
                    'Protein': foodHarmingValues.protein < 0
                        ? 0
                        : foodHarmingValues.protein,
                    'Carbohydrate, by difference':
                        foodHarmingValues.carbohydrate < 0
                            ? 0.0
                            : foodHarmingValues.carbohydrate,
                    'Total lipid (fat)': foodHarmingValues.totalLipidFat < 0
                        ? 0.0
                        : foodHarmingValues.totalLipidFat,
                    'Sugars, total including NLEA':
                        foodHarmingValues.sugarsTotalIncludingNLEA < 0
                            ? 0.0
                            : foodHarmingValues.sugarsTotalIncludingNLEA,
                    'Fatty acids, total trans':
                        foodHarmingValues.fattyAcidsTotalTrans < 0
                            ? 0.0
                            : foodHarmingValues.fattyAcidsTotalTrans,
                    'Fatty acids, total saturated':
                        foodHarmingValues.fattyAcidsTotalSaturated < 0
                            ? 0.0
                            : foodHarmingValues.fattyAcidsTotalSaturated,
                  };
                  // print(foodValues);
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              if (state.isLoading)
                                const CircularProgressIndicator(),
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(state.pickedImagePathname),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Banana',
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(193, 221, 85, 75),
                                      ),
                                      // required
                                      child: Column(
                                        children: [
                                          Text(
                                            'Food Index',
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${getAverage(harmingValues.values.toList())} %',
                                            style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(193, 221, 85, 75),
                                      ),
                                      // required
                                      child: Column(
                                        children: [
                                          Text(
                                            "Today's Index",
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '40 %',
                                            style: GoogleFonts.roboto(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                                children: harmingValues.entries
                                    .map((e) => _ingredientCard(
                                        title: e.key.toString(),
                                        value: e.value))
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                              //FoodListView(),
                              // Text(
                              //   context
                              //       .read<FoodBloc>()
                              //       .state
                              //       .foods[0]['foodNutrients']
                              //       .toString(),
                              // ),
                              // Text(getDaywiseLimit('Type 2 diabetes', 1)
                              //     .toString()),
                              // Text(getDaywiseLimitWithGivenFood(
                              //   diseaseName: 'Type 2 diabetes',
                              //   severity: 1,
                              //   foodNutrients: (context
                              //           .read<FoodBloc>()
                              //           .state
                              //           .foods[0]['foodNutrients'] ??
                              //       []) as List<dynamic>,
                              //   currentLimits: DaywiseLimit.empty,
                              // ).toString()),
                              // Text(getHarmingValues(
                              //   diseaseName: 'Type 2 diabetes',
                              //   severity: 3,
                              //   foodNutrients: (context
                              //           .read<FoodBloc>()
                              //           .state
                              //           .foods[0]['foodNutrients'] ??
                              //       []) as List<dynamic>,
                              //   currentLimits: DaywiseLimit.empty,
                              // ).toString()),
                              SizedBox(height: 300),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: CustomFloatingActionButton(
                          foodLimitValue: foodLimitValues,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _ingredientCard({
    required String title,
    required double value,
  }) {
    Color color;
    if (value <= 70) {
      color = Color.fromARGB(123, 142, 255, 145);
    } else if (value >= 100) {
      color = Color.fromARGB(113, 255, 140, 132);
    } else {
      color = Color.fromARGB(104, 248, 241, 177);
    }

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Text(title),
            Text(
              value.toStringAsFixed(2) + " %",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getAverage(List<double> list) {
  double total = 0;
  list.forEach((element) {
    total = total + element;
  });
  return (total / list.length).toStringAsFixed(2);
}

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key, required this.foodLimitValue});
  final DaywiseLimit foodLimitValue;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  bool isLoading = false;
  bool isConsumed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: InkWell(
        onTap: isLoading || isConsumed
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                  isConsumed = false;
                });
                print('Clicked');
                try {
                  await FirebaseUserRepository().consumeFood(
                    uid: context.read<UserBloc>().uid,
                    daywiseLimit: widget.foodLimitValue,
                    foodDetails: FoodDetails(
                      id: Timestamp.now().toDate().toIso8601String(),
                      foodLink: context.read<FoodBloc>().state.foodImageLink,
                      foodName: (context.read<FoodBloc>().state.foods[0]
                              ['description'] ??
                          "") as String,
                      disease: context.read<UserBloc>().state.user.disease,
                      diseaseSeverity:
                          context.read<UserBloc>().state.user.diseaseSeverity,
                      timestamp: Timestamp.now(),
                    ),
                  );
                  setState(() {
                    isLoading = false;
                    isConsumed = true;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = true;
                    isConsumed = false;
                  });
                  print(e);
                }
              },
        borderRadius: BorderRadius.circular(200),
        child: Container(
          // height: 100,
          decoration: BoxDecoration(
            color: isConsumed ? Colors.green : Colors.blue,
            borderRadius: BorderRadius.circular(200),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: isLoading
              ? CircularProgressIndicator()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(isConsumed ? 'Consumed' : 'Consume'),
                    const SizedBox(width: 10),
                    Icon(isConsumed ? Icons.done : Icons.dinner_dining),
                  ],
                ),
        ),
      ),
    );
  }
}
