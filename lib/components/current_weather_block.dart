import 'package:flutter/material.dart';

class CurrentWeatherBlock extends StatefulWidget {
  @override
  createState() => _currentWeatherBlockState();
}

class _currentWeatherBlockState extends State {
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      height: 170,
      child: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(
                        0, 7), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Right now',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Container(
                            child: Text(
                                  '25°C',
                                  style: TextStyle(fontSize: 35),
                                )
                          ),
                        ]
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Mostly sunny',
                              style: TextStyle(fontSize: 22),
                            ),
                            Image.asset(
                              'images/sunny_rainy.png',
                              width: 100,
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
