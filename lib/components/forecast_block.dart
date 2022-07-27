import 'package:flutter/material.dart';
import 'package:weather_app/components/detailed_current_weather.dart';
import 'package:weather_app/components/hourly_weather.dart';
import 'package:weather_app/components/daily_weather.dart';

class ForecastBlock extends StatefulWidget {
  late String cityName;

  ForecastBlock({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _forecastBlockState(cityName: cityName);
}

class _forecastBlockState extends State {
  bool detailsPressed = false;
  bool hourlyPressed = true;
  bool dailyPressed = false;

  late String cityName;

  _forecastBlockState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: _getButtonColor(detailsPressed)),
                    onPressed: () {
                      setState(() {
                        detailsPressed = true;
                        hourlyPressed = false;
                        dailyPressed = false;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: _getButtonColor(hourlyPressed)),
                    onPressed: () {
                      setState(() {
                        detailsPressed = false;
                        hourlyPressed = true;
                        dailyPressed = false;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Hourly',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: _getButtonColor(dailyPressed)),
                    onPressed: () {
                      setState(() {
                        detailsPressed = false;
                        hourlyPressed = false;
                        dailyPressed = true;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Forecast',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                  ),
                ],
              ),
            ),
            _getCurrentSection()
          ],
        ));
  }

  Widget _getCurrentSection() {
    if (hourlyPressed)
      return HourlyWeather();
    else if (dailyPressed)
      return DailyWeather(cityName: cityName);
    else
      return DetailedCurrentWeather(cityName: cityName);
  }

  MaterialStateProperty<Color> _getButtonColor(bool isPressed) {
    final buttonColor = isPressed ? Colors.blue : Colors.grey.shade200;
    return MaterialStateProperty.all<Color>(buttonColor);
  }
}
