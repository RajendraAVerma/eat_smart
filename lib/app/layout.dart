import 'package:authentication_repository/authentication_repository.dart';
import 'package:eat_smart/app/blocs/food/food_bloc.dart';
import 'package:eat_smart/app/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';

class GlobalLayout extends StatelessWidget {
  const GlobalLayout({super.key, required this.child});
  final Widget child;
  static Widget show({required Widget child}) {
    return GlobalLayout(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodBloc(
        uid: "adsf",
        context: context,
      ),
      child: BlocProvider(
        create: (context) => UserBloc(context.read<AuthBloc>().state.user.id),
        // child: UserChecking(child: child),
        child: child,
      ),
    );
  }
}

class UserChecking extends StatelessWidget {
  const UserChecking({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            body: LinearProgressIndicator(),
          );
        }
        if (state.error != "") {
          return Scaffold(
            body: Text(state.error),
          );
        }
        if (state.user.isEmpty || state.user.disease.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Fill Form'),
            ),
            body: UserForm(),
          );
        }
        return child;
      },
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
  });

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  List<String> getDiseaseList() {
    return [
      'Obesity',
      'Asthma',
      'Osteoporosis',
      "Meniere's disease",
      'Diabetes',
      'Stomach cancer',
      'Attacks to the brain',
      'Hypertension',
      'Heart failure',
      'Kidney stones',
      'Weight gain',
      'Chronic inflammation',
      'Fatty liver',
      'Heart attack',
      'Acne',
      'Cancer',
      'Depression',
      'Increase skin aging',
      'Cellular aging',
      'Cavities',
      'Gout',
      'Tooth decay',
      'Noninsulin-dependent diabetes',
      'High cholesterol',
      'High serum insulin',
      'Fatigue',
      'Gall bladder stone',
      'Breast cancer',
      'Coronary heart disease',
      'Type-2 diabetes',
      'Insomnia',
    ];
  }

  String? selectedDisease;
  int? diseaseServerity;
  String? displayName;

  @override
  void initState() {
    super.initState();
    if (context.read<UserBloc>().state.user.disease.isNotEmpty) {
      selectedDisease = context.read<UserBloc>().state.user.disease;
    }
    if (context.read<UserBloc>().state.user.diseaseSeverity != 0) {
      diseaseServerity = context.read<UserBloc>().state.user.diseaseSeverity;
    }
    if (context.read<UserBloc>().state.user.displayName.isNotEmpty) {
      displayName = context.read<UserBloc>().state.user.displayName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                displayName = value;
              });
            },
            initialValue: displayName,
            decoration: InputDecoration(
              hintText: 'Enter Name',
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedDisease,
            hint: Text('Select a disease'),
            onChanged: (value) {
              setState(() {
                selectedDisease = value ?? "";
              });
            },
            items: getDiseaseList()
                .map<DropdownMenuItem<String>>((String disease) {
              return DropdownMenuItem<String>(
                value: disease,
                child: Text(disease),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            value: diseaseServerity,
            hint: Text('Select a Serverity'),
            onChanged: (value) {
              setState(() {
                diseaseServerity = value ?? 0;
              });
            },
            items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: selectedDisease != null && diseaseServerity != null
                ? () {
                    context.read<UserBloc>().add(SetUser(
                          UserModel(
                            id: context.read<AuthBloc>().state.user.id,
                            email: context.read<AuthBloc>().state.user.email,
                            mobile: context.read<AuthBloc>().state.user.mobile,
                            name: displayName,
                            photo: context.read<AuthBloc>().state.user.photo,
                          ),
                          selectedDisease ?? "",
                          diseaseServerity ?? 0,
                        ));
                  }
                : null,
            icon: const Icon(Icons.arrow_right),
            label: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
