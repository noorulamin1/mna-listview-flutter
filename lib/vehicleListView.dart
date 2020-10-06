import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vehicle{
  final String name;
  final String fuelType;
  final String vehicleModel;
  final String year;

  Vehicle({this.name, this.fuelType, this.vehicleModel, this.year});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      name: json['name'],
      fuelType: json['fuelType'],
      vehicleModel: json['vehiclesNo'],
      year: json['model'],
    );
  }
}

class VehicleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: _fetchVehicle(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Vehicle> data = snapshot.data;
          return _vehiclesListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Vehicle>> _fetchVehicle() async {
    // your url with parameters
     var uri = new Uri.http("your_url", "path", { "PhoneNo" : '123456778' });
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((car) => new Vehicle.fromJson(car)).toList();
    } else {
      throw Exception('Error');
    }
  }

  ListView _vehiclesListView(data) {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].name, data[index].fuelType, Icons.directions_car);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title ?? 'default value',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle ?? 'default value'),
        leading: Icon(
          icon,
          color: Colors.red,
        ),
      );
}