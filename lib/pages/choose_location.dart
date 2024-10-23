import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {


  List<WorldTime> locations = [
  WorldTime(url:  'Europe%2FBerlin', location: 'Berlin', flag: 'germany.png'),
  WorldTime(url:  'Europe%2FAmsterdam',  location: 'Amsterdam', flag: 'egypt.png'),
  WorldTime(url:  'Europe%2FRome', location: 'Rome', flag: 'italy.png'),
    WorldTime(url:  'Asia%2FKolkata',  location: 'Kolkata', flag: 'india.png'),
  WorldTime(url:  'Europe%2FMadrid',  location: 'Madrid', flag: 'spain.png'),
  WorldTime(url:  'Europe%2FLisbon',  location: 'Lisbon', flag: 'portugal.png'),
    WorldTime(url:  'Europe%2FLondon',  location: 'London', flag: 'uk.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();

    print({
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });

    // navigate to home screen
    Navigator.pop(context , {
      'location': instance.location ?? 'Unknown',  // Default value
      'flag': instance.flag ?? 'default.png',      // Default value
      'time': instance.time ?? 'Unavailable',      // Default value for time
      'isDaytime': instance.isDaytime ?? true,     // Default value for isDaytime

    });

  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
