import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? click;

  const TimerButton({
    Key? key,
    required this.text,
    required this.icon,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          textStyle: TextStyle(fontSize: 25),
        ),
        onPressed: this.click,
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            SizedBox(width: 10),
            Text(text),
          ],
        ));
  }
}
