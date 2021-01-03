import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/datamodel.dart';

import 'httpservice.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Welcome> futureWeather;

  @override
  void initState() {
    super.initState();

    futureWeather = fetchWeather("rzeszow");
    futureWeather
        .then((value) => {log(value.name), log(value.main.temp.toString())});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prognoza pogody'),
        ),
        body: Center(
            child: Container(
          alignment: Alignment.center,
          color: Colors.deepOrange,
          child: Column(
            children: <Widget>[
              FutureBuilder<Welcome>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.name,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
