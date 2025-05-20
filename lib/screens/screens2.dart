import 'package:flutter/material.dart';

class Screens2 extends StatelessWidget {
  const Screens2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("assets/images/2.jpg"),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Effortless & Automatic",
            style: TextStyle(
              color: Color.fromARGB(255, 246, 244, 244),
              fontSize: 35,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
        ),

        const SizedBox(height: 20,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time.",
            style: TextStyle(
              color: Color.fromARGB(255, 246, 244, 244),
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
