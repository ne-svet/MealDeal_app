import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreenStripe extends StatelessWidget {
  final screenName;
  final IconData? screenIcon;
  //final IconData? backIcon;
  final VoidCallback? onPressedScreenIcon;

  GreenStripe(
      {super.key,
      required this.screenName,
      this.screenIcon,
      required this.onPressedScreenIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF62BD5C),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              screenName,
              style: const TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            if (screenIcon != null)
              IconButton(
                onPressed: onPressedScreenIcon,
                color: Colors.white,
                icon: Icon(screenIcon),
              )
          ],
        ),
      ),
    );
  }
}
