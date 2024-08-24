import 'package:flutter/material.dart';

//TODO: Import service.dart file
import 'package:udemy_environ_chamber/service/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //TODO: Create an instance of the RelayService class
  final Service service = Service();

  //TODO: Call the initGpio16Output method in the initState method
  @override
  void initState() {
    service.initGpioOutput();
    super.initState();
  }

  //TODO: Call the disposeGpio method in the dispose method
  @override
  void dispose() {
    service.disposeGpio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Create a Scaffold widget
    return Scaffold(
      //TODO: Add an AppBar widget
      appBar: AppBar(
        title: const Text('Environmental Chamber'),
        centerTitle: true,
      ),
      //TODO: Add a Center widget
      body: Center(
        //TODO: Add a Column widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //TODO: Add getTemperatureLow method
            getTemperatureLow(),
            const SizedBox(height: 20),
            //TODO: Add getTemperatureOkay method
            getTemperatureOkay(),
            const SizedBox(height: 20),
            //TODO: Add getTemperatureHigh method
            getTemperatureHigh(),
          ],
        ),
      ),
    );
  }

//TODO: Create the getElevatedButtonRelayOn method
  Widget getTemperatureLow() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          service.flashLed(true, 500, 500);
          // service.gpio16OutputLevel(false); // Green LED
          service.gpio17OutputLevel(true); // Red LED
          service.gpio22OutputLevel(false); // Active Buzzer: active low
          service.gpio23OutputLevel(true); // Relay for heater
          service.gpio24OutputLevel(false); // Vent Motor
        });
      },
      child: const Text(
        'Temperature Low',
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }

//TODO: Create the getElevatedButtonRelayOff method
  Widget getTemperatureOkay() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          service.flashLed(false, 500, 500);
          // service.gpio16OutputLevel(true); // Green LED
          service.gpio17OutputLevel(false); // Red LED
          service.gpio22OutputLevel(true); // Active Buzzer: active low
          service.gpio23OutputLevel(false); // Relay for heater
          service.gpio24OutputLevel(false); // Vent Motor
        });
      },
      child: const Text(
        'Temperature Okay',
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }

  Widget getTemperatureHigh() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          service.gpio16OutputLevel(false); // Green LED
          service.gpio17OutputLevel(true); // Red LED
          service.gpio22OutputLevel(false); // Active Buzzer: active low
          service.gpio23OutputLevel(false); // Relay for heater
          service.gpio24OutputLevel(true); // Vent Motor
        });
      },
      child: const Text(
        'Temperature High',
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }
}
