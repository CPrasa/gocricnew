import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key, this.buttonText, this.onTap, this.color, this.textColor});
  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: color!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            buttonText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor!,
            ),
          ),
        ),
      ),
    );
  }
}
