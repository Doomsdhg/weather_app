import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class CityManagementDialog {

  Future build(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Input city name to add'),
        actions: <Widget>[
          _AutoCompleteInput(),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _AutoCompleteInput extends StatelessWidget {

  static String _displayStringForOption(String option) => option;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return await _findCities(textEditingValue.text);
      }
    );
  }

  Future<Iterable<String>> _findCities(String input) async {
    Iterable<String> citiesList = await WeatherApi().findCities(input);
    return citiesList;
  }
}