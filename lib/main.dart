import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/rendering.dart';
import 'package:kordobi_calculator/toolkit/special_button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userQuestion = '';
  var userAnswer = '';

// تحضير الازرار
  final List<String> buttons = [
    '(',
    ')',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];

  @override
  void initState() {
    super.initState();
    // هذه الخاصية تجعل نافذة التطبيق صغيرة
    DesktopWindow.setMaxWindowSize(Size(280, 520));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  // النصف الذي يحتوي المعادلات
                  Expanded(
                      child: Container(
                    color: Color(0xff000706),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            userQuestion,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "NanumGothic"),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(20),
                        ),
                        Container(
                          child: Text(
                            userAnswer,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: "NanumGothic"),
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(20),
                        )
                      ],
                    ),
                  )),
                  // النصف الذي يحتوي الازرار
                  Expanded(
                    flex:
                        2, // هذه الخاصية تجعل النصف الذي يحتوي الازرار اكبر مرتين من النصف الاول
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color(0xff000807),
                              Color(0xff0d1d24)
                            ])),
                        child: GridView.builder(
                            itemCount: buttons.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (BuildContext context, int index) {
                              // زر حذف الشاشة في المستقبل
                              // if (index == 0) {
                              //   return Container(
                              //     decoration: BoxDecoration(
                              //         border:
                              //             Border.all(color: Color(0xff000706))),
                              //     child: SpecialButton(
                              //       buttonTapped: () {
                              //         setState(() {
                              //           userQuestion = '';
                              //         });
                              //       },
                              //       color: Colors.transparent,
                              //       textColor: Colors.white,
                              //       buttonText: buttons[index],
                              //     ),
                              //   );
                              // }

                              //  زر حذف كلمة واحدة
                              if (index == buttons.length - 2) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff000706))),
                                  child: SpecialButton(
                                    buttonTapped: () {
                                      setState(() {
                                        userQuestion = userQuestion.substring(
                                            0, userQuestion.length - 1);
                                      });
                                    },
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    buttonText: buttons[index],
                                  ),
                                );
                              }

                              // زر التساوي
                              else if (index == buttons.length - 1) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff000706))),
                                  child: SpecialButton(
                                      buttonTapped: () {
                                        setState(() {
                                          equalPressed();
                                        });
                                      },
                                      color: Color(0xff23988e),
                                      textColor: Colors.white,
                                      buttonText: buttons[index]),
                                );
                              }

                              // باقي الازرار
                              else {
                                return Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff000706))),
                                  child: SpecialButton(
                                    buttonTapped: () {
                                      setState(() {
                                        userQuestion += buttons[index];
                                      });
                                    },
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    buttonText: buttons[index],
                                  ),
                                );
                              }
                            })),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // خصائص التساوي
  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
