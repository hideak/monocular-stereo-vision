import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './connectioninfo.dart';

/// Define the Home widget that will be displayed first to the user
class Home extends StatefulWidget {
  final String appTitle;
  final String socketIP;
  final int socketPort;

  /// Widget Constructor
  Home(this.appTitle, this.socketIP, this.socketPort);

  /// State Constructor
  @override
  _HomeState createState() => _HomeState();
}

/// Defines the state of the Home Widget
class _HomeState extends State<Home> {
  double accX, accY, accZ; // Accelerometer Properties
  double angAccX, angAccY, angAccZ; // Gyroscope Properties
  bool isConnected = false;
  StreamSubscription accelerometerSubscription;
  StreamSubscription gyroscopeSubscription;
  Stream<SensorEvent> streamSensorEvent;
  IO.Socket socket;

  /// Home Widget User Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.appTitle,
              style: TextStyle(fontSize: 24),
            ),
            Container(height: 20),
            MaterialButton(
              child: Text('Iniciar Medição'),
              onPressed: startMeasuring,
            ),
            MaterialButton(
              child: Text('Parar Medição'),
              onPressed: stopMeasuring,
            ),
            MaterialButton(
              child: Text('Conectar ao Socket'),
              onPressed: () {
                connectToSocket(widget.socketIP, widget.socketPort);
              },
            ),
            Container(height: 20),
            Text('accX: $accX'),
            Text('accY: $accY'),
            Text('accZ: $accZ'),
            Text('angAccX: $angAccX'),
            Text('angAccY: $angAccY'),
            Text('angAccZ: $angAccZ'),
            Container(height: 20),
            ConnectionInfo(isConnected),
          ],
        ),
      ),
    );
  }

  /// Subscribes to a stream to listen for accelerometer and gyroscope
  /// data provided by the smartphone sensors
  void startMeasuring() async {
    streamSensorEvent = await SensorManager().sensorUpdates(
      sensorId: Sensors.ACCELEROMETER,
      interval: Sensors.SENSOR_DELAY_FASTEST,
    );

    accelerometerSubscription = streamSensorEvent
      .listen((sensorEvent) {
        setState(() {
          accX = sensorEvent.data[0];
          accY = sensorEvent.data[1];
          accZ = sensorEvent.data[2];
        });
    });

    gyroscopeSubscription = streamSensorEvent
      .listen((sensorEvent) {
        setState(() {
          angAccX = sensorEvent.data[0];
          angAccY = sensorEvent.data[1];
          angAccZ = sensorEvent.data[2];
        });
    });
  }

  /// Unregister from the accelerometer and gyroscope streams
  void stopMeasuring() {
    accelerometerSubscription.cancel();
    gyroscopeSubscription.cancel();
  }

  /// Stablishes a connection to a Web Socket for transferring
  /// accelerometer and gyroscope data
  /// [socketIP] The IP addres that serves the Web Socket Server
  /// [socketPort] The port used to serve the Web Socket Server
  void connectToSocket(String socketIP, int socketPort) {
    socket = IO.io('$socketIP:$socketPort', <String, dynamic>{
      'transports': ['websocket']
    });
    socket.on('connect', onSocketConnection);
  }

  /// Callback that will be executed after a successful connection.
  dynamic onSocketConnection(dynamic data) {
    setState(() {
      isConnected = true;
    });
  }
}
