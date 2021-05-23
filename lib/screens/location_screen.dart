import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //Values taken from OpenWeatherMaps
  int temp1, temp2, temp3, temp4, temp5;
  String city, day1, day2, day3, day4, day5, today, time;
  double wind1, wind2, wind3, wind4, wind5;

  WeatherModel weatherModel = WeatherModel();

  //Icons
  String weatherIcon1, weatherIcon2, weatherIcon3, weatherIcon4, weatherIcon5;
  String citySearch;

  //Derived from raw data
  String tempMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp1 = 100;
        tempMessage = '😖 Uhh';
        city = 'Apologies';
        time = "We don't";
        today = "Know where that is";
        weatherIcon1 = "😕";
        wind1 = 0.0;
        return;
      }
      var temperature = weatherData['list'][0]['main']['temp'];
      temp1 = temperature.toInt();
      tempMessage = weatherModel.getMessage(temp1);

      temp2 = (weatherData['list'][1]['main']['temp']).toInt();
      temp3 = (weatherData['list'][2]['main']['temp']).toInt();
      temp4 = (weatherData['list'][3]['main']['temp']).toInt();
      temp5 = (weatherData['list'][4]['main']['temp']).toInt();

      weatherIcon1 = weatherModel
          .getWeatherIcon(weatherData['list'][0]['weather'][0]['id']);
      weatherIcon2 = weatherModel
          .getWeatherIcon(weatherData['list'][1]['weather'][0]['id']);
      weatherIcon3 = weatherModel
          .getWeatherIcon(weatherData['list'][2]['weather'][0]['id']);
      weatherIcon4 = weatherModel
          .getWeatherIcon(weatherData['list'][3]['weather'][0]['id']);
      weatherIcon5 = weatherModel
          .getWeatherIcon(weatherData['list'][4]['weather'][0]['id']);

      city = weatherData['city']['name'];

      //Date and Time formatting
      var unixDate = weatherData['list'][0]['dt'];
      var date = DateTime.fromMillisecondsSinceEpoch(unixDate * 1000);
      var dateNow = DateTime.now();

      time = DateFormat.jm().format(dateNow);
      today = DateFormat.yMMMMEEEEd().format(date);
      day1 = DateFormat.E().format(date);

      day2 = DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(
          (weatherData['list'][6]['dt']) * 1000));
      day3 = DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(
          (weatherData['list'][14]['dt']) * 1000));
      day4 = DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(
          (weatherData['list'][22]['dt']) * 1000));
      day5 = DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(
          (weatherData['list'][30]['dt']) * 1000));

      // String weatherDesc = weatherData['list'][0]['weather'][0]['description'];

      //WindSpeeds
      wind1 = weatherData['list'][0]['wind']['speed'];
      wind2 = weatherData['list'][1]['wind']['speed'];
      wind3 = weatherData['list'][2]['wind']['speed'];
      wind4 = weatherData['list'][3]['wind']['speed'];
      wind5 = weatherData['list'][4]['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.00),
                    backgroundBlendMode: BlendMode.overlay,
                    gradient: new LinearGradient(
                      colors: [Colors.red, Colors.cyan],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      // end: new Alignment(-1.0, -1.0),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$tempMessage',
                                textAlign: TextAlign.center,
                                style: kLabelTextStyle.copyWith(fontSize: 20),
                              ),
                              Text(
                                '📍$city',
                                style: kLabelTextStyle.copyWith(fontSize: 25),
                              ),
                              Text(
                                '⏰ $time', //can be more fine tuned
                                style: kLabelTextStyle.copyWith(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp1°C',
                              style: kLabelTextStyle.copyWith(fontSize: 38),
                            ),
                            Text(
                              today,
                              style: kLabelTextStyle.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.overlay,
                    gradient: new LinearGradient(
                      colors: [Colors.red, Colors.cyan],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              day1,
                              style: kLabelTextStyle.copyWith(fontSize: 30),
                            ),
                            Text(
                              '🌡$temp1°C',
                              style: kLabelTextStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '$weatherIcon1',
                              style: kLabelTextStyle,
                            ),
                            Text('💨 ${wind1}m/s'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              day2,
                              style: kLabelTextStyle.copyWith(fontSize: 30),
                            ),
                            Text(
                              '🌡$temp2°C',
                              style: kLabelTextStyle.copyWith(fontSize: 18),
                            ),
                            Text(
                              '$weatherIcon2',
                              style: kLabelTextStyle,
                            ),
                            Text('💨${wind2}m/s'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              day3,
                              style: kLabelTextStyle.copyWith(fontSize: 30),
                            ),
                            Text(
                              '🌡$temp3°C',
                              style: kLabelTextStyle.copyWith(fontSize: 18),
                            ),
                            Text(
                              '$weatherIcon3',
                              style: kLabelTextStyle,
                            ),
                            Text('💨${wind3}m/s'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              day4,
                              style: kLabelTextStyle.copyWith(fontSize: 30),
                            ),
                            Text(
                              '🌡$temp4°C',
                              style: kLabelTextStyle.copyWith(fontSize: 18),
                            ),
                            Text(
                              '$weatherIcon4',
                              style: kLabelTextStyle,
                            ),
                            Text('💨${wind4}m/s'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              day5,
                              style: kLabelTextStyle.copyWith(fontSize: 30),
                            ),
                            Text(
                              '🌡$temp5°C',
                              style: kLabelTextStyle.copyWith(fontSize: 18),
                            ),
                            Text(
                              '$weatherIcon5',
                              style: kLabelTextStyle,
                            ),
                            Text('💨${wind5}m/s'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.00),
                    backgroundBlendMode: BlendMode.overlay,
                    gradient: new LinearGradient(
                      colors: [Colors.red, Colors.cyan],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TextButton(
                            child: Text(
                              'Local',
                              style: kButtonTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () async {
                                  updateUI(
                                      await weatherModel.getLocationWeather());
                                },
                              );
                            }),
                      ),
                      Expanded(
                        child: TextButton(
                            child: Text(
                              'By City🔎',
                              style: kButtonTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                            onPressed: () {
                              setState(() async {
                                citySearch = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CityScreen()));
                                if (citySearch != null) {
                                  setState(() async {
                                    var weatherData = await weatherModel
                                        .getCityWeather(citySearch);
                                    updateUI(weatherData);
                                  });
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// FlatButton(
// onPressed: () {
// setState(() async {
// updateUI(await weatherModel.getLocationWeather());
// });
// },
// child: Icon(
// Icons.near_me,
// size: 50.0,
// ),
// ),
// FlatButton(
// onPressed: () {
// setState(() async {
// citySearch = await Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// CityScreen()));
// if (citySearch != null) {
// setState(() async {
// var weatherData =
// await weatherModel.getCityWeather(citySearch);
// updateUI(weatherData);
// });
// }
// });
// },
// child: Icon(
// Icons.location_city,
// size: 50.0,
// ),
// ),
// ],
// ),
//
// Text(
// weatherIcon,
// style: kConditionTextStyle,
// ),
