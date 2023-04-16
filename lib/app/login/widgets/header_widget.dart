import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class headerWidget extends StatelessWidget {
  const headerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Image.asset(
            //   'images/_logo.png',
            //   scale: 3.5,
            // ),
            const SizedBox(height: 20),
            Text(
              "Welcome to",
              style: GoogleFonts.getFont(
                'Cabin',
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            Text(
              "Eat Smart",
              style: GoogleFonts.getFont(
                'Cabin',
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Sign in to continue",
              style: GoogleFonts.getFont(
                'Cabin',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
