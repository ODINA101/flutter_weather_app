import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() {
  logger.d('ra yleeobaa');
  runApp(MaterialApp(title: "Wheather app", home: Home()));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var wind_speed;
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.weatherstack.com/current?access_key=9f8ba0f742a22e2e95bb0190ac2a7ec1&query=New%20York"));
    var results = jsonDecode(response.body);
    logger.d(results["current"]);
    this.setState(() {
      this.temp = results["current"]["temperature"];
      this.description = results["current"]["weather_descriptions"][0];
      this.currently = results["current"]["temperature"];
      this.humidity = results["current"]["humidity"];
      this.wind_speed = results["current"]["wind_speed"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.9,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("Currently in Georgia",
                        style: TextStyle(fontSize: 14.0, color: Colors.white))),
                Text(temp != null ? temp.toString() + "40\u00B0" : "Loading",
                    style: TextStyle(color: Colors.white, fontSize: 40.0))
              ]),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text('Temperature'),
                    trailing: Text(temp != null
                        ? temp.toString() + "52\u00B0"
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Wheather'),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('TemperaHumiditure'),
                    trailing: Text(humidity.toString() != null
                        ? humidity.toString()
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('WindSpeed'),
                    trailing: Text(wind_speed != null
                        ? wind_speed.toString()
                        : "Loading..."),
                  )
                ])))
      ],
    ));
  }
}
