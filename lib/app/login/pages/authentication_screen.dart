import 'package:eat_smart/app/login/pages/verify_phone_number_screen.dart';
import 'package:eat_smart/app/login/utils/helpers.dart';
import 'package:eat_smart/app/login/widgets/header_widget.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AuthenticationScreen extends StatefulWidget {
  static const id = 'AuthenticationScreen';

  const AuthenticationScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String? phoneNumber;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: headerWidget(),
            ),
            _loginWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _loginWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 3,
              width: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter Your Phone Number",
              style: GoogleFonts.getFont(
                'Cabin',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            EasyContainer(
              margin: 0,
              elevation: 0,
              borderRadius: 10,
              color: Colors.transparent,
              child: Form(
                key: _formKey,
                child: IntlPhoneField(
                  showCountryFlag: false,
                  autofocus: false,
                  invalidNumberMessage: 'Invalid Phone Number!',
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontSize: 25),
                  onChanged: (phone) => phoneNumber = phone.completeNumber,
                  initialCountryCode: 'IN',
                  flagsButtonPadding: const EdgeInsets.only(right: 20),
                  showDropdownIcon: false,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                if (isNullOrBlank(phoneNumber) ||
                    !_formKey.currentState!.validate()) {
                  showSnackBar('Please enter a valid phone number!');
                } else {
                  print(phoneNumber.toString());
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VerifyPhoneNumberScreen(phoneNumber: phoneNumber!),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "SEND OTP",
                  style: GoogleFonts.getFont(
                    'Cabin',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "I agree to the terms & conditions",
              style: GoogleFonts.getFont(
                'Cabin',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
