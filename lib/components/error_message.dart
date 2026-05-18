import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

class ErrorMessage extends StatelessWidget {
  final String title, message;

  const ErrorMessage({required this.title, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_rounded, size: 150),

            SizedBox(height: 20),

            Text(title, style: kDetailsTextStyle),

            SizedBox(height: 8),

            Text(
              message,
              style: kLocationTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
