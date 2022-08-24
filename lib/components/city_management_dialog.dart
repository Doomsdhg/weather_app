import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/api/weather_api.dart';

class CityManagementDialog {

  String? inputValue;

  void inputCallback(String value){
    inputValue = value;
  }

  String? getSelectedCity(){
    return inputValue;
  }

  Future build(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context){
        bool buttonDisabled = true;
        return StatefulBuilder(
          builder:(context, setState) => AlertDialog(
            title: const Text('City name'),
            actions: <Widget>[
              _AutoCompleteInput(
                inputCallback,
                getSelectedCity,
                (){
                  setState((){
                    buttonDisabled = true;
                  });
                }, 
                (){
                  setState((){
                    buttonDisabled = false;
                  });
                }
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: getButtonColor(buttonDisabled)
                ),
                onPressed: (){
                  if (!buttonDisabled){
                    return Navigator.pop(context, '$inputValue');
                  }
                },
                child: const Text('Add'),
              ),
            ],
          )
        );
      },
    );
  }

  MaterialStateProperty<Color> getButtonColor(bool buttonDisabled){
    return buttonDisabled ? MaterialStateProperty.all<Color>(Colors.grey.shade400) : MaterialStateProperty.all<Color>(Colors.white);
  }
}

class _AutoCompleteInput extends StatelessWidget {

  late Function(String) inputCallback;

  late Function getSelectedCity;

  late Function disableButton;

  late Function enableButton;

  _AutoCompleteInput(this.inputCallback, this.getSelectedCity, this.disableButton, this.enableButton);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: ((context, textEditingController, focusNode, onFieldSubmitted){
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          onChanged: (value){
            if (value != getSelectedCity()){
              disableButton();
            }
          },
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
        enableButton();
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