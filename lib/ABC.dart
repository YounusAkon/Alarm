import 'package:flutter/material.dart';
import 'location_service.dart';
import 'new.dart';

class abc1 extends StatefulWidget {
  const abc1({super.key});

  @override
  State<abc1> createState() => _abc1State();
}

class _abc1State extends State<abc1> {
  String _locationMessage = "";

  void _getLocation() async {
    final position = await LocationService.getCurrentLocation();

    if (position != null) {
      setState(() {
        _locationMessage =
            "Selected Location:\nLat: ${position.latitude}, Lng: ${position.longitude}";
      });
    } else {
      setState(() {
        _locationMessage = "Location permission denied.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome! Your Personalized Alarm",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Allow us to sync your sunset alarm based on your location.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/4.jpg",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _getLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 59, 59, 59),
                padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Use Current Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.location_on, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _locationMessage,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 59, 59, 59),
                padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
