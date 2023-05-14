import 'dart:ui';

import 'package:eat_smart/app/blocs/auth/auth_bloc.dart';
import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/blocs/user/user_bloc.dart';
import 'package:eat_smart/app/home/widgets/search_food_box.dart';
import 'package:eat_smart/app/home/widgets/today_consumed_food.dart';
import 'package:eat_smart/app/layout.dart';
import 'package:eat_smart/app/theme/theme_manager.dart';
import 'package:eat_smart/utils/getDateId.dart';
import 'package:eat_smart/utils/getDiseaseLimits.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eat Smart'),
        actions: [
          Consumer<ThemeNotifier>(builder: (context, theme, _) {
            final themeMode = theme.getThemeMode();
            return IconButton(
              onPressed: () {
                if (themeMode == ThemeMode.dark) {
                  theme.setLightMode();
                } else {
                  theme.setDarkMode();
                }
              },
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            );
          }),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AppLogoutRequested());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person_rounded),
            label: "Account",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<FoodBloc>().add(ResetAll());
          await getImage();
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return LinearProgressIndicator();
          }
          if (state.status == AppStatus.unauthenticated) {
            return LinearProgressIndicator();
          }
          return BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome'),
                              Text(
                                context.read<UserBloc>().state.user.displayName,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return UserForm();
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.red.withOpacity(0.2),
                                      ),
                                      child: Text(
                                        context
                                            .read<UserBloc>()
                                            .state
                                            .user
                                            .disease,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.blue.withOpacity(0.2),
                                      ),
                                      child: Text(
                                        context
                                            .read<UserBloc>()
                                            .state
                                            .user
                                            .diseaseSeverity
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL, // default
                            front: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue.withOpacity(0.2),
                              ),
                              // required

                              child: StreamBuilder<DaywiseLimit>(
                                stream:
                                    FirebaseUserRepository().getDaywiseLimit(
                                  uid: context.read<UserBloc>().uid,
                                  dayId: getDateId(),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Text(
                                          'Daily Index',
                                          style: GoogleFonts.roboto(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          getDailyIndex(
                                            diseaseName: context
                                                .read<UserBloc>()
                                                .state
                                                .user
                                                .disease,
                                            severity: context
                                                .read<UserBloc>()
                                                .state
                                                .user
                                                .diseaseSeverity,
                                            currentLimit: snapshot.data!,
                                          ),
                                          style: GoogleFonts.roboto(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(snapshot.error.toString());
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                            back: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.teal.withOpacity(0.2),
                              ),
                              // required
                              child: Column(
                                children: [
                                  Text(
                                    'Weekly Index',
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '400',
                                    style: GoogleFonts.roboto(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TodayConsumedFood(),
                      ],
                    ),
                  ),
                  if (state.isLoading)
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 1.0,
                        sigmaY: 1.0,
                      ),
                      child: Container(
                        child: Center(
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (pickedImage != null)
      context
          .read<FoodBloc>()
          .add(PickImageEvent(pickedImage, pickedImage.path));
  }
}
