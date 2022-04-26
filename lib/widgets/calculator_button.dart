import 'package:flutter/material.dart';

enum CalculatorButtonType {
  text,
  icon
}

class CalculatorButton extends StatelessWidget {
  final Function onPressed;
  final String? text;
  final IconData? icon;
  final CalculatorButtonType type;
  final TextEditingController? controller;
  final double? fontSize;
  final Color? primary;
  final Color? onPrimary;

  const CalculatorButton({required this.type, required this.onPressed, this.controller, this.text, this.icon, this.primary, this.onPrimary, this.fontSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ElevatedButton.styleFrom(
              onSurface: Colors.purple,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              primary: primary ?? Theme.of(context).colorScheme.primary,
              shadowColor: Colors.black,
              elevation: 5,
            ),
            child: content(context),
          ),
        ),
      )
    );
  }

  Widget content(BuildContext context) {
    switch (type) {
      case CalculatorButtonType.text:
        return textContent(context);
      case CalculatorButtonType.icon:
        return iconContent(context);
    }
  }

  Widget textContent(BuildContext context) {
    return Text(text!,
      style: TextStyle(
        color: onPrimary ?? Theme.of(context).colorScheme.onPrimary,
        fontSize: fontSize ?? 22
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget iconContent(BuildContext context) {
    return Icon(
      icon,
      color: onPrimary ?? Theme.of(context).colorScheme.onPrimary,
    );
  }
}
