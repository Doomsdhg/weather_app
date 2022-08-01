import 'package:flutter/material.dart';

class InfoDialog {

  Future build(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Weather app'),
        content: Column(
          children: [
            Text('Version: 0.1.0 '),
            Text('Contact me: tohanknv@yandex.ru'),
            Text('Known bugs: '),
            Text('Fixes bugs: ')
          ],
        ),
      ),
    );
  }
}