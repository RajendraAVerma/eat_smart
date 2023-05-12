import 'dart:io';

import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/home/widgets/foods_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.food_bank),
      ),
      body: SafeArea(
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (state.isLoading) const CircularProgressIndicator(),
                    Container(
                      height: 200,
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
                    SizedBox(height: 20),
                    Text(
                      'Banana',
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    FoodListView(),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
