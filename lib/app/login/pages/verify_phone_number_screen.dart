import 'package:eat_smart/app/login/utils/helpers.dart';
import 'package:eat_smart/app/login/widgets/custom_loader.dart';
import 'package:eat_smart/app/login/widgets/header_widget.dart';
import 'package:eat_smart/app/login/widgets/pin_input_field.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';

  final String phoneNumber;

  const VerifyPhoneNumberScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        autoRetrievalTimeOutDuration: const Duration(seconds: 60),
        otpExpirationDuration: const Duration(seconds: 60),
        onCodeSent: () {
          log(VerifyPhoneNumberScreen.id, msg: 'OTP sent!');
        },
        onLoginSuccess: (userCredential, autoVerified) async {
          log(
            VerifyPhoneNumberScreen.id,
            msg: autoVerified
                ? 'OTP was fetched automatically!'
                : 'OTP was verified manually!',
          );

          showSnackBar('Phone number verified successfully!');

          log(
            VerifyPhoneNumberScreen.id,
            msg: 'Login Success UID: ${userCredential.user?.uid}',
          );
          await Future.delayed(const Duration(seconds: 2));

          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   HomeScreen.id,
          //   (route) => false,
          // );
          // context.go('/dashboard');
        },
        onLoginFailed: (authException, stackTrace) {
          log(
            VerifyPhoneNumberScreen.id,
            msg: authException.message,
            error: authException,
            stackTrace: stackTrace,
          );
          switch (authException.code) {
            case 'invalid-phone-number':
              // invalid phone number
              return showSnackBar('Invalid phone number!');
            case 'invalid-verification-code':
              // invalid otp entered
              return showSnackBar('The entered OTP is invalid!');
            // handle other error codes
            default:
              showSnackBar('Something went wrong! : ' +
                  authException.message.toString());
            // handle error further if needed
          }
        },
        onError: (error, stackTrace) {
          log(
            VerifyPhoneNumberScreen.id,
            error: error,
            stackTrace: stackTrace,
          );

          showSnackBar('An error occurred!');
        },
        builder: (context, controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: headerWidget()),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: controller.isSendingCode
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                CustomLoader(),
                                SizedBox(height: 50),
                                Center(
                                  child: Text(
                                    'Sending OTP',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
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
                                Row(
                                  children: [
                                    Text(
                                      "Verify Phone Number",
                                      style: GoogleFonts.getFont(
                                        'Cabin',
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (controller.codeSent)
                                      TextButton(
                                        onPressed: controller.isOtpExpired
                                            ? () async {
                                                log(VerifyPhoneNumberScreen.id,
                                                    msg: 'Resend OTP');
                                                await controller.sendOTP();
                                              }
                                            : null,
                                        child: Text(
                                          controller.isOtpExpired
                                              ? 'Resend'
                                              : '${controller.otpExpirationTimeLeft.inSeconds}s',
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 18),
                                        ),
                                      ),
                                  ],
                                ),
                                const Divider(),
                                Text(
                                  "We've sent an SMS with a verification code to ${widget.phoneNumber}",
                                  style: GoogleFonts.getFont(
                                    'Cabin',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(),
                                if (controller.isListeningForOtpAutoRetrieve)
                                  Column(
                                    children: [
                                      CustomLoader(),
                                      SizedBox(height: 50),
                                      Text(
                                        'Reading Automatic OTP',
                                        style: GoogleFonts.getFont(
                                          'Cabin',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Divider(),
                                      Text('OR', textAlign: TextAlign.center),
                                      Divider(),
                                    ],
                                  ),
                                const SizedBox(height: 15),
                                Text(
                                  "Enter Your OTP",
                                  style: GoogleFonts.getFont(
                                    'Cabin',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                PinInputField(
                                  length: 6,
                                  // onFocusChange: (hasFocus) async {
                                  //   if (hasFocus)
                                  //     await _scrollToBottomOnKeyboardOpen();
                                  // },

                                  onSubmit: (enteredOtp) async {
                                    final verified =
                                        await controller.verifyOtp(enteredOtp);
                                    if (verified) {
                                      // number verify success
                                      // will call onLoginSuccess handler
                                    } else {
                                      // phone verification failed
                                      // will call onLoginFailed or onError callbacks with the error
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
