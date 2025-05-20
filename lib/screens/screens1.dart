import 'package:flutter/material.dart';

class Screens1 extends StatelessWidget {
  const Screens1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("assets/images/1.jpg"),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Sync with Nature’s Rhythm",
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
            "Experience a peaceful transition into the evening with an alarm that aligns with the sunset.Your perfect reminder, always 15 minutes before sundown",
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
