import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class DetailsWidget extends StatelessWidget {
  final String title, value;

  const DetailsWidget({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value, style: kDetailsTextStyle),
            Visibility(
              visible: title == 'Wind' ? true : false,
              child: Text(' Km/hr', style: kDetailsSuffixStyle),
            ),
          ],
        ),
        Text(title, style: kDetailsTitleTextStyle),
      ],
    );
  }
}
