import 'package:authentication_repository/authentication_repository.dart';
import 'package:eat_smart/app/blocs/auth/auth_bloc.dart';
import 'package:eat_smart/app/login/utils/globals.dart';
import 'package:eat_smart/app/router.dart';
import 'package:eat_smart/app/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';

import 'login/pages/login.dart';

Widget myMain() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            AuthBloc(authenticationRepository: AuthenticationRepository()),
      ),
    ],
    child: ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
      // child: const AuthGate(),
    ),
  );
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AppStatus.authenticated) {
          return MyApp();
        }
        if (state.status == AppStatus.unauthenticated) {
          return const LoginPage();
        }
        return MaterialApp(
          home: Scaffold(
            body: const LinearProgressIndicator(),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Consumer<ThemeNotifier>(
          builder: (context, theme, _) {
            return MaterialApp.router(
              localizationsDelegates: const [
                FormBuilderLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              darkTheme: ThemeData.dark(
                useMaterial3: true,
              ).copyWith(
                outlinedButtonTheme: const OutlinedButtonThemeData(
                  style: ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        width: 0.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  // filled: true,
                  contentPadding: const EdgeInsets.only(left: 20),
                  filled: true,
                  border: const OutlineInputBorder(gapPadding: 1),
                  hintStyle:
                      const TextStyle(fontSize: 18.0, color: Colors.grey),
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              themeMode: theme.getThemeMode(),
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: AppBarTheme(),
                primaryTextTheme: Typography().black,
                // or white
                outlinedButtonTheme: const OutlinedButtonThemeData(
                  style: ButtonStyle(
                      side: MaterialStatePropertyAll(BorderSide(width: 0.3))),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 20),
                  border: const OutlineInputBorder(gapPadding: 1),
                  hintStyle:
                      const TextStyle(fontSize: 18.0, color: Colors.grey),
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).primaryColorLight),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).primaryColorLight),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: Globals.scaffoldMessengerKey,
              // routerConfig: appRouter.goRouter,
              routeInformationParser: appRouter.goRouter.routeInformationParser,
              routeInformationProvider:
                  appRouter.goRouter.routeInformationProvider,
              routerDelegate: appRouter.goRouter.routerDelegate,
            );
          },
        );
      },
    );
  }
}
