import 'package:flutter/material.dart';
import 'package:weatherapp/datamodel.dart';
import 'package:weatherapp/datamodel_week.dart';
import 'package:weatherapp/httpservice.dart';

void main() {
  runApp(MaterialApp(
    title: "Pogoda",
    home: Weatherapp(),
  ));
}

class Weatherapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherappState();
  }
}

class _WeatherappState extends State<Weatherapp> {
  String miasto;
  Future<Welcome> pogoda;
  List<String> miasta;
  Future<Week> pogoda_week;

  //pierwsze wywołanie
  @override
  void initState() {
    super.initState();

    //this.miasta = ['Rzeszów', 'Warszawa', 'Rosja'];
    this.miasto = 'Rzeszów';
    pogoda = fetchWeather(this.miasto);
    pogoda_week = fetchWeatherWeek(this.miasto);
  }

  //budowanie wyglądu widgetu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prognoza Pogody"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 90),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.pinkAccent, Colors.deepPurple],
        )),
        child: Column(
          children: <Widget>[
            Text(""),
            // Temperatura
            FutureBuilder<Welcome>(
              future: pogoda,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data.main.temp.round().toString()}°C",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            FutureBuilder<Welcome>(
              future: pogoda,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data.weather.first.description}\n",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            FutureBuilder<Welcome>(
              future: pogoda,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "\nOdczuwalna: ${snapshot.data.main.feelsLike.toString()}°C\nCiśnienie: ${snapshot.data.main.pressure.toString()} Pa\nWilgotność: ${snapshot.data.main.humidity.toString()}%",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            //Dropdown theme
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.purple,
              ),
              child: //Dropdown Container
                  Container(
                margin: const EdgeInsets.only(top: 40),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white.withOpacity(.8),
                ),
                child:
                    //Dropdown
                    DropdownButton<String>(
                  value: miasto,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  //dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String newValue) {
                    // SETSTATE
                    setState(() {
                      miasto = newValue;
                      pogoda = fetchWeather(miasto);
                      pogoda_week = fetchWeatherWeek(miasto);
                    });
                  },
                  items: <String>[
                    'Białystok',
                    'Bydgoszcz',
                    'Gdańsk',
                    'Katowice',
                    'Kielce',
                    'Kraków',
                    'Lublin',
                    'Łódź',
                    'Olsztyn',
                    'Opole',
                    'Poznań',
                    'Rzeszów',
                    'Szczecin',
                    'Toruń',
                    'Warszawa',
                    'Wrocław',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                          width: 200,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Column(
              children: [
                //dzien1
                FutureBuilder<Week>(
                  future: pogoda_week,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${snapshot.data.list[8].dtTxt.day.toString()}/${snapshot.data.list[8].dtTxt.month.toString()}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data.list[8].main.temp.round()}/${snapshot.data.list[11].main.temp.round()}°C',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                //dzien2
                FutureBuilder<Week>(
                  future: pogoda_week,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${snapshot.data.list[16].dtTxt.day.toString()}/${snapshot.data.list[16].dtTxt.month.toString()}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data.list[16].main.temp.round()}/${snapshot.data.list[19].main.temp.round()}°C',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                //dzien3
                FutureBuilder<Week>(
                  future: pogoda_week,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${snapshot.data.list[23].dtTxt.day.toString()}/${snapshot.data.list[23].dtTxt.month.toString()}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data.list[23].main.temp.round()}/${snapshot.data.list[26].main.temp.round()}°C',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                //dzien4
                FutureBuilder<Week>(
                  future: pogoda_week,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${snapshot.data.list[31].dtTxt.day.toString()}/${snapshot.data.list[31].dtTxt.month.toString()}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data.list[31].main.temp.round()}/${snapshot.data.list[34].main.temp.round()}°C',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
            Text(
              'Dane: OpenWeatherMap',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
