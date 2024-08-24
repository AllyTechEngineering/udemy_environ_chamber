// TODO: Import Packages
import 'dart:async';

import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/foundation.dart';

class Service {
  // TODO: Define variables for GPIO pins
  dynamic gpio16;
  dynamic gpio17;
  dynamic gpio22;
  dynamic gpio23;
  dynamic gpio24;
    // Timer to control the LED flashing
  Timer? _flashTimer;

  // TODO: Initialize GPIOs as an output
  void initGpioOutput() {
    try {
      gpio16 = GPIO(16, GPIOdirection.gpioDirOut); // Green LED
      gpio17 = GPIO(17, GPIOdirection.gpioDirOut); // Red LED
      gpio22 = GPIO(22, GPIOdirection.gpioDirOut); // Active Buzzer: active low
      gpio23 = GPIO(23, GPIOdirection.gpioDirOut); // Relay for heater
      gpio24 = GPIO(24, GPIOdirection.gpioDirOut); // Vent Motor
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // TODO: Set the output level of GPIO
  // Green LED
  void gpio16OutputLevel(bool outputValue) {
    debugPrint('gpio16 outputValue: $outputValue');
    gpio16.write(outputValue);
  }

// Red LED
  void gpio17OutputLevel(bool outputValue) {
    debugPrint('gpio17 outputValue: $outputValue');
    gpio17.write(outputValue);
  }

// Active Buzzer: active low
  void gpio22OutputLevel(bool outputValue) {
    debugPrint('gpio22 outputValue: $outputValue');
    gpio22.write(outputValue);
  }

// Relay for heater
  void gpio23OutputLevel(bool outputValue) {
    debugPrint('gpio23 outputValue: $outputValue');
    gpio23.write(outputValue);
  }

// Vent Motor
  void gpio24OutputLevel(bool outputValue) {
    debugPrint('gpio24 outputValue: $outputValue');
    gpio24.write(outputValue);
  }

  // Method to flash the LED
  // Arguments:
  // - start: boolean to start or stop flashing
  // - timeOn: duration in milliseconds the LED stays on
  // - timeOff: duration in milliseconds the LED stays off
  void flashLed(bool start, int timeOn, int timeOff) {
    if (start) {
      // If flashing is to be started, set up the periodic timer
      _flashTimer = Timer.periodic(Duration(milliseconds: timeOn + timeOff), (timer) {
        gpio16OutputLevel(true);
        Future.delayed(Duration(milliseconds: timeOn), () {
          gpio16OutputLevel(false);
        });
      });
    } else {
      // If flashing is to be stopped, cancel the timer
      _flashTimer?.cancel();
      gpio16OutputLevel(false);
    }
  }
  // TODO: Dispose of the GPIO resources
  void disposeGpio() {
    gpio16.dispose(); // Green LED
    gpio17.dispose(); // Red LED
    gpio22.dispose(); // Active Buzzer
    gpio23.dispose(); // Relay for heater
    gpio24.dispose(); // Vent Motor
  }
}
