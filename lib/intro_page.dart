import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 60, 55),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 25),

            //shop name
            Text(
              "SHUSHI MAN",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            //icon
            Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('assets/fried-rice.png')),

            const SizedBox(height: 25),

            //title
            Text(
              "THE TASTE OF MALAYSIAN FOOD",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            //subtitle
            Text(
              "Feel the taste of the most popular Malaysian Food",
              style: TextStyle(
                color: Colors.grey[300],
                height: 2,
              ),
            ),

            const SizedBox(height: 25),

            //get started butotn
            MyButton(
              text: "Get Started!",
              onTap: () {
                //go to menu page
                Navigator.pushNamed(context, '/bookingpage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
