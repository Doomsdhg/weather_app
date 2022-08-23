import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
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
      fieldViewBuilder: ((context, textEditingController, focusNode, onFieldSubmitted){
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
        );
      }),
      optionsViewBuilder: (context, onSelected, options) {
          return FractionallySizedBox(
            widthFactor: 0.65,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Material(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(height: 2, color: Colors.grey,),
                    itemCount: options.length,
                    itemBuilder: (context, index){
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100
                        ),
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              onSelected(options.elementAt(index));
                            },
                            child: ListTile(
                              title: Text(
                                options.elementAt(index),
                                style: TextStyle(
                                  fontSize: FontConstants.SMALL_SIZE
                                ),  
                              ),
                            )
                          ),
                        )
                      );
                    }
                  )

                ),
              ],
            ),
          );
      },
      displayStringForOption: _displayStringForOption,
      onSelected: (String value){
        inputCallback(value);
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.length > 0)
          return await _findCities(textEditingValue.text);
        else
          return List.empty();
      }
    );
  }

  static String _displayStringForOption(String option) => option;



  Future<Iterable<String>> _findCities(String input) async {
    Iterable<String> citiesList = await WeatherApi().findCities(input);
    return citiesList;
  }
}