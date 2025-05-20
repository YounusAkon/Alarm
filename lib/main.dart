import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task1/ABC.dart';
import 'package:task1/screens/screens1.dart';
import 'package:task1/screens/screens2.dart';
import 'package:task1/screens/screens3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void nextOrSkip() {
    if (currentIndex < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to abc1 page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => abc1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [Screens1(), Screens2(), Screens3()],
          ),

          // SmoothPageIndicator and Button
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Page indicator
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotColor: Color.fromARGB(255, 118, 118, 118),
                    activeDotColor: Color.fromARGB(108, 122, 48, 207),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ), // Spacing between indicator and button
                // Next button
                SizedBox(
                  width: double.infinity, // Make button full-width
                  child: ElevatedButton(
                    onPressed: nextOrSkip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color.fromRGBO(110, 76, 234, 1),
                      foregroundColor:Color.fromARGB(255, 254, 254, 254),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Next",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
