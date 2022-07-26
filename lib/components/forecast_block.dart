import 'package:flutter/material.dart';
import 'package:weather_app/components/hourly_weather.dart';
import 'package:weather_app/components/weather_forecast.dart';

class ForecastBlock extends StatefulWidget {
  @override
  createState() => _forecastBlockState();
}

class _forecastBlockState extends State {
  bool detailsPressed = false;
  bool hourlyPressed = true;
  bool forecastPressed = false;

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
                      forecastPressed = false;
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
                      forecastPressed = false;
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
                      backgroundColor: _getButtonColor(forecastPressed)),
                  onPressed: () {
                    setState(() {
                      detailsPressed = false;
                      hourlyPressed = false;
                      forecastPressed = true;
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
      )
    );
  }

  Widget _getCurrentSection(){
    if (hourlyPressed)
      return HourlyWeather();
    else
      return DailyWeather();
  }

  MaterialStateProperty<Color> _getButtonColor(bool isPressed) {
    final buttonColor = isPressed ? Colors.blue : Colors.grey.shade200;
    return MaterialStateProperty.all<Color>(buttonColor);
  }
}
