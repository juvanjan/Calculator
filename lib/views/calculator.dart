import 'dart:math';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:calculator/internal/constants.dart';
import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/exchanger.dart';
import 'package:calculator/internal/extensions.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController resultController = TextEditingController();
  TextEditingController equationController = TextEditingController();
  StringBuffer buffer = StringBuffer();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 330),
              padding: const EdgeInsets.fromLTRB(7, 40, 7, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    constraints: const BoxConstraints(minHeight: 70),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Constants.formRadius),
                          topRight: Radius.circular(Constants.formRadius),
                          bottomLeft: Radius.circular(Constants.formRadius),
                          bottomRight: Radius.circular(Constants.formRadius)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Center(
                      child: AutoSizeTextField(
                        readOnly: true,
                        textAlign: TextAlign.end,
                        controller: resultController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 52
                        ),
                        maxLines: 10,
                        minLines: 1,
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Constants.formRadius),
                          topRight: Radius.circular(Constants.formRadius),
                          bottomLeft: Radius.circular(Constants.formRadius),
                          bottomRight: Radius.circular(Constants.formRadius)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: AutoSizeTextField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      controller: equationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        isDense: true,
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20
                      ),
                      maxLines: 10,
                      minLines: 1,
                    ),
                  ),

                  Row(
                    children: [
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () {
                          clear();
                        },
                        text: "AC",
                        onPrimary: getFunctionColor(context),
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("("); },
                        text: "(",
                        onPrimary: getFunctionColor(context),
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText(")"); },
                        text: ")",
                        onPrimary: getFunctionColor(context),
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("/"); },
                        text: "\u00F7",
                        onPrimary: getFunctionColor(context),
                        fontSize: 28,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("7"); },
                        text: "7",
                        controller: equationController,
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("8"); },
                        text: "8",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("9"); },
                        text: "9",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.icon,
                        onPressed: () { addText("*"); },
                        icon: Icons.close,
                        onPrimary: getFunctionColor(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("4"); },
                        text: "4",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("5"); },
                        text: "5",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("6"); },
                        text: "6",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.icon,
                        onPressed: () { addText("-"); },
                        icon: Icons.remove,
                        onPrimary: getFunctionColor(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("1"); },
                        text: "1",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("2"); },
                        text: "2",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("3"); },
                        text: "3",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.icon,
                        onPressed: () { addText("+"); },
                        icon: Icons.add,
                        onPrimary: getFunctionColor(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("0"); },
                        text: "0",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { addText("."); },
                        text: ".",
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.icon,
                        onPressed: () {
                          delete();
                        },
                        icon: Icons.backspace_outlined,
                      ),
                      CalculatorButton(
                        type: CalculatorButtonType.text,
                        onPressed: () { calculate(); },
                        text: "=",
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ],
                  ),

                  Exchanger(
                    convert: convert,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getFunctionColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  void setDisplayFromBuffer() {
    equationController.text = buffer.toString()
        .replaceAll('/', " \u00F7 ")
        .replaceAll('*', " \u00D7 ")
        .replaceAll('-', " - ")
        .replaceAll('+', " + ");
  }

  void addText(String text) {
    if (isFunctionText(text) && !canAddFunction(isMinus: text == '-')) {
      delete();
    }

    buffer.write(text);
    setDisplayFromBuffer();
  }

  void clear() {
    buffer.clear();
    equationController.clear();
    resultController.clear();
  }

  void delete() {
    String text = buffer.toString();
    if (text.isNotEmpty) {
      buffer.clear();
      buffer.write(text.substring(0, text.length - 1));
    }
    setDisplayFromBuffer();
  }

  void calculate() {
    String equation = buffer.toString();
    if (equation.isEmpty) {
      clear();
      return;
    }

    Parser parser = Parser();
    ContextModel contextModel = ContextModel();

    try {
      Expression expression = parser.parse(equation);
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      resultController.text = simplifyDoubleString(result.toString());
    } on FormatException catch (_) {
      resultController.text = Constants.formatError;
    } on RangeError catch (_) {
      resultController.text = Constants.formatError;
    }
  }

  String simplifyDoubleString(String text) {
    if (text.length > 2 && text.endsWith(".0")) {
      return text.substring(0, text.length - 2);
    } else {
      return text;
    }
  }

  bool canAddFunction({bool isMinus = false}) {
    if (buffer.toString().isEmpty) {
      return isMinus ? true : false;
    }

    String last = buffer.toString().lastChar();
    switch (last) {
      case '+': return isMinus ? true : false;
      case '-': return false;
      case '*': return isMinus ? true : false;
      case '/': return isMinus ? true : false;
      case '(': return isMinus ? true : false;
      default: return true;
    }
  }

  bool isFunctionText(String text) {
    switch (text) {
      case '+': return true;
      case '-': return true;
      case '*': return true;
      case '/': return true;
      default: return false;
    }
  }

  void convert(double modifier) {

    bool resultValid = true;
    try {
      double.parse(resultController.text);
    } on Exception catch (_) {
      resultValid = false;
    }

    if (resultController.text.isNotEmpty && resultValid) {
      var doubleValue = roundDouble(double.parse(resultController.text) * modifier, 4);
      var value = simplifyDoubleString(doubleValue.toString());
      resultController.text = value;
      equationController.text = value;
    } else if (equationController.text.isNotEmpty) {
      try {
        var doubleValue = roundDouble(double.parse(equationController.text) * modifier, 4);
        var value = simplifyDoubleString(doubleValue.toString());
        resultController.text = value;
        equationController.text = value;
      } on Exception catch (_) {
        resultController.text = Constants.convertError;
      }
    } else {
      resultController.text = Constants.convertError;
    }


  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }

}