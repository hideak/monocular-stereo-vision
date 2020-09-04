import 'package:flutter/material.dart';


/// Defines the ConnectionInfo Widget that display information about
/// a socket connection
class ConnectionInfo extends StatefulWidget {
  final bool isConnected;

  ConnectionInfo(this.isConnected);

  @override
  _ConnectionInfoState createState() => _ConnectionInfoState();
}

/// Defines the state of the ConnectionInfo Widget
class _ConnectionInfoState extends State<ConnectionInfo> {
  @override
  Widget build(BuildContext context) {
    String connectionInfo = widget.isConnected
      ? "Connected" : "Disconnected";
    return Text(connectionInfo);
  }
}
