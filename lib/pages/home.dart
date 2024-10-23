import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Get the passed arguments or use an empty Map if null
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;


    // Handle nulls by providing a default value, e.g., false for 'isDaytime'
    bool isDaytime = data['isDaytime'] ?? false;

    // Set background image and color based on the 'isDaytime' flag
    String bgImage = isDaytime ? 'day.png' : 'night.png';
    Color? bgColor = isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'] ?? 'Unkown time',
                          'location': result['location'] ?? 'Unkown Location',
                          'isDaytime': result['isDaytime'] ?? true,
                          'flag': result['flag'] ?? 'default.png'
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[600],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'] ?? 'Unknown Location', // Handle null for location
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'] ?? 'Unknown Time', // Handle null for time
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
