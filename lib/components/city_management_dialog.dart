import 'package:flutter/material.dart';
import 'package:weather_app/services/api/weather_api.dart';

class CityManagementDialog {

  late String inputValue;

  void inputCallback(String value){
    inputValue = value;
  }

  Future build(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('City name'),
        actions: <Widget>[
          _AutoCompleteInput(inputCallback),
          TextButton(
            onPressed: () => Navigator.pop(context, '$inputValue'),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _AutoCompleteInput extends StatelessWidget {

  final Function(String) inputCallback;

  _AutoCompleteInput(this.inputCallback);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      onSelected: (String value){
        inputCallback(value);
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return await _findCities(textEditingValue.text);
      }
    );
  }

  static String _displayStringForOption(String option) => option;

  Future<Iterable<String>> _findCities(String input) async {
    Iterable<String> citiesList = await WeatherApi().findCities(input);
    return citiesList;
  }
}