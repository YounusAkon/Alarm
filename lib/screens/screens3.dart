import 'package:flutter/material.dart';

class Screens3 extends StatelessWidget {
  const Screens3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("assets/images/3.jpg"),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Relax & Unwind",
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
            "hope to take the courage to pursue your dreams.",
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
