import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final degree = '\u00B0';
  String city = 'Search',
      tempInDegree = '00',
      feelLike = '0',
      humidity = 'unknown',
      weather = ' cloudy',
      windSpeed = '23',
      pressure = 'pddd';

  final appColour = Color(int.parse('FF6908D6', radix: 16));

  PreferredSizeWidget appBarWithSearch() {
    return AppBar(
      title: Container(
        height: 38,
        child: TextField(
            onSubmitted: (word) {
              http
                  .get(
                      'https://api.openweathermap.org/data/2.5/weather?q=$word&appid=6e6d323afd01215cb7d5168672baab6e')
                  .then((value) {
                debugPrint(value.toString());
                dynamic response = JsonDecoder().convert(value.body);

                setState(() {
                  tempInDegree = (response.main.temp - 273.15).toString();
                  feelLike = (response.main.feelLike - 273.15).toString();
                  humidity = (response.main.humidity).toString();
                  pressure = (response.main.pressure).toString();
                  windSpeed = (response.wind.speed).toString();
                  weather = response.weather.o.description;
                  city = word;
                });
              });
            },
            textAlign: TextAlign.justify,
            decoration: InputDecoration(
                hintText: "Search a city...",
                suffixIcon: Icon(Icons.location_searching_sharp),
                focusColor: Colors.grey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.only(bottom: 38 / 2, left: 8))),
      ),
      elevation: 0,
      backgroundColor: Colors.white12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWithSearch(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.white),
                        Text(city,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('$tempInDegree$degree',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text('Feels like $feelLike$degree',
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.white))
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: appColour),
              ),
              SizedBox(height: 30),
              ListTile(
                tileColor: appColour.withOpacity(0.1),
                leading: FaIcon(
                  FontAwesomeIcons.thermometerHalf,
                  color: appColour,
                ),
                title: Text('Temperature',
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                trailing: Text(tempInDegree,
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ListTile(
                tileColor: appColour.withOpacity(0.1),
                leading: FaIcon(
                  FontAwesomeIcons.water,
                  color: appColour,
                ),
                title: Text('Humidity',
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                trailing: Text(humidity,
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ListTile(
                tileColor: appColour.withOpacity(0.1),
                leading: FaIcon(
                  FontAwesomeIcons.cloud,
                  color: appColour,
                ),
                title: Text('Weather',
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                trailing: Text(weather,
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ListTile(
                tileColor: appColour.withOpacity(0.1),
                leading: FaIcon(
                  FontAwesomeIcons.wind,
                  color: appColour,
                ),
                title: Text('Wind Speed',
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                trailing: Text(windSpeed,
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ListTile(
                tileColor: appColour.withOpacity(0.1),
                leading: FaIcon(
                  FontAwesomeIcons.weight,
                  color: appColour,
                ),
                title: Text('Pressure',
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                trailing: Text(pressure,
                    style: TextStyle(
                        color: appColour,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
