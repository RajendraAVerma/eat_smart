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
        if (state.user.isEmpty) {
          return Scaffold(
              body: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                context
                    .read<UserBloc>()
                    .add(SetUser(context.read<AuthBloc>().state.user));
              },
              icon: const Icon(Icons.arrow_right),
              label: const Text("Continue"),
            ),
          ));
        }
        return child;
      },
    );
  }
}
