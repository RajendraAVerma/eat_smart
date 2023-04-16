import 'package:eat_smart/app/login/pages/authentication_screen.dart';
import 'package:eat_smart/app/login/utils/globals.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:form_builder_validators/localization/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.only(left: 20),
            border: const OutlineInputBorder(gapPadding: 1),
            hintStyle: const TextStyle(fontSize: 18.0, color: Colors.grey),
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor),
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
        home: const Scaffold(
          body: AuthenticationScreen(),
        ),
      ),
    );
  }
}
