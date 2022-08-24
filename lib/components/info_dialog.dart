import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/constants/constants.dart';

class InfoDialog {

  Future build(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Weather app',
          style: TextStyle(
            fontSize: FontConstants.MIDDLE_SIZE
          ),
        ),
        content: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text(
                'Version: 0.1.0 ',
                style: TextStyle(
                  fontSize: FontConstants.SMALL_SIZE
                ),
            ),
            Text(
                'Contact me: tohanknv@yandex.ru',
                style: TextStyle(
                  fontSize: FontConstants.SMALL_SIZE
                ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                  text: 'About',
                  style: new TextStyle(
                    color: Colors.blue,
                    fontSize: FontConstants.SMALL_SIZE
                    ),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse('https://github.com/Doomsdhg/weather_app#weather_app')),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}