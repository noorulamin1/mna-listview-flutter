import 'package:flutter/material.dart';
import 'vehicleListView.dart';

// void main() {
//   runApp(App());
// }
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vehicle List'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: VehicleListView()
        ),
      ),
    );
  }
}