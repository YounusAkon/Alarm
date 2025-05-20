/*import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  List<Map<String, String>> alarms = [
    {'time': '7:10 pm', 'date': 'Fri 21 Mar 2025'},
    {'time': '6:55 pm', 'date': 'Fri 28 Mar 2025'},
    {'time': '7:00 pm', 'date': 'Fri 04 Apr 2025'},
  ];

  List<bool> switchStates = [true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Container(
          width: 360,
          height: 700,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Location",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.white70, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "79 Regent’s Park Rd, London\nNW1 8UY, United Kingdom",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Pick time
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime == null) return;

                      // Pick date
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate == null) return;

                      // Format time
                      final formattedTime =
                          "${pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? "am" : "pm"}";

                      // Format date
                      final formattedDate =
                          "${_weekdayString(pickedDate.weekday)} ${pickedDate.day.toString().padLeft(2, '0')} ${_monthString(pickedDate.month)} ${pickedDate.year}";

                      // Add alarm
                      setState(() {
                        alarms.add({
                          'time': formattedTime,
                          'date': formattedDate,
                        });
                        switchStates.add(true);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2D2D2D),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Add Alarm", style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Alarms",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 12),
                ...alarms.asMap().entries.map((entry) {
                  int index = entry.key;
                  var alarm = entry.value;
                  return AlarmTile(
                    time: alarm['time']!,
                    date: alarm['date']!,
                    isActive: switchStates[index],
                    onToggle: (val) {
                      setState(() {
                        switchStates[index] = val;
                      });
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _weekdayString(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[(weekday - 1) % 7];
  }

  String _monthString(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[(month - 1) % 12];
  }
}

class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const AlarmTile({
    required this.time,
    required this.date,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
*/






import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(MaterialApp(home: NewPage()));

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  // List of alarms
  List<Map<String, String>> alarms = [
    {'time': '7:10 pm', 'date': 'Fri 21 Mar 2025'},
    {'time': '6:55 pm', 'date': 'Fri 28 Mar 2025'},
    {'time': '7:00 pm', 'date': 'Fri 04 Apr 2025'},
  ];
  List<bool> switchStates = [true, true, true];

  // Location-related variables
  String selectedLocation = "Fetching location...";
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _listenToLocationChanges();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  // Subscribe to location changes
  void _listenToLocationChanges() async {
    // Check for permissions first.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        setState(() {
          selectedLocation = "Location permission denied";
        });
        return;
      }
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
  locationSettings: LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  ), // update every 10 meters
    ).listen((Position position) async {
      // Reverse geocode the coordinates.
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          String address =
              "${place.street}, ${place.locality}\n${place.postalCode}, ${place.country}";
          setState(() {
            selectedLocation = address;
          });
        }
      } catch (e) {
        setState(() {
          selectedLocation = "Error fetching address";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Container(
          width: 360,
          height: 700,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Selected Location",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                // Display location (updates as location changes)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.white70, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedLocation,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Add Alarm Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Pick time
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime == null) return;

                      // Pick date
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate == null) return;

                      // Format time
                      final formattedTime =
                          "${pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? "am" : "pm"}";

                      // Format date
                      final formattedDate =
                          "${_weekdayString(pickedDate.weekday)} ${pickedDate.day.toString().padLeft(2, '0')} ${_monthString(pickedDate.month)} ${pickedDate.year}";

                      // Add the new alarm to the list
                      setState(() {
                        alarms.add({
                          'time': formattedTime,
                          'date': formattedDate,
                        });
                        switchStates.add(true);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2D2D2D),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Add Alarm", style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 24),
                // Alarms title
                Text(
                  "Alarms",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 12),
                // List of alarms
                ...alarms.asMap().entries.map((entry) {
                  int index = entry.key;
                  var alarm = entry.value;
                  return AlarmTile(
                    time: alarm['time']!,
                    date: alarm['date']!,
                    isActive: switchStates[index],
                    onToggle: (val) {
                      setState(() {
                        switchStates[index] = val;
                      });
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper functions to format weekday and month values.
  String _weekdayString(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[(weekday - 1) % 7];
  }

  String _monthString(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[(month - 1) % 12];
  }
}

// AlarmTile widget remains unchanged.
class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const AlarmTile({
    required this.time,
    required this.date,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
