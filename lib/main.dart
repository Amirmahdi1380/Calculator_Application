import 'package:flutter/material.dart';
import 'package:calculator_application/constant.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  const CalculatorApplication({Key? key}) : super(key: key);

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  @override
  var inputUser = '';
  var result = '';
  void ButtonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: BackgraoundColor(text1),
          ),
          //BackgraoundColor(Colors.green),
          onPressed: () {
            if (text1 == 'ac') {
              inputUser = '';
              result = '';
            } else {
              ButtonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: BackgroundGreen(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: BackgraoundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.isNotEmpty) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              ButtonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text2,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: BackgroundGreen(text2)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: BackgraoundColor(text3),
          ),
          onPressed: () {
            ButtonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text3,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: BackgroundGreen(text3)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: BackgraoundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else
              ButtonPressed(text4);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text4,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: BackgroundGreen(text4)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'vazir'),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        inputUser,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: backgroundgreen),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 62,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '=')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isOprator(String text) {
  var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
  for (var item in list) {
    if (text == item) {
      return true;
    }
  }
  return false;
}

Color BackgraoundColor(String text) {
  if (isOprator(text)) {
    return backgroundGreyDark;
  }
  return backgroundGrey;
}

Color BackgroundGreen(String text) {
  if (isOprator(text)) {
    return backgroundgreen;
  }
  return textGrey;
}
