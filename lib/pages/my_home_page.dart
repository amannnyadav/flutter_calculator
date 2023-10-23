import 'package:flutter/material.dart';
import 'package:flutter_calculator/components/buttons/my_buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion ="";
  var userAnswer="";
  final List<String> buttons=[
    "C","DEL","%","/",
    "9","8","7","x",
    "6","5","4","+",
    "3","2","1","-",
    "0",".","ANS","=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Column(
        children: [
          //user question and answer is here
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion,style: TextStyle(fontSize: 30,color: Colors.deepPurple.shade900)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(userAnswer,style:TextStyle(fontSize: 30,color: Colors.deepPurple.shade900)),
                  ),
                ),
              ],
            ),
          ),

          //buttons
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index){
                //clear all button
                if(index==0){
                  return MyButton(
                    color: Colors.green,
                    textColor:Colors.white,
                    buttonText: buttons[index],
                    buttonTapped: (){
                      setState(() {
                        userQuestion="";
                      });
                    }
                  );
                }
                //delete button
                else if(index ==1){
                  return MyButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                    buttonTapped: (){
                      setState(() {
                        if(userQuestion.isNotEmpty){
                          userQuestion=userQuestion.substring(0,userQuestion.length-1);
                        }
                        else{
                          userQuestion="";
                        }
                      });
                    }
                  );
                }
                // is equal to button
                else if(index ==buttons.length-1){
                  return MyButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      }
                  );
                }
                else if(index ==buttons.length-2){
                  return MyButton(
                      color: Colors.deepPurple.shade50,
                      textColor: Colors.deepPurple,
                      buttonText: buttons[index],
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      }
                  );
                }
                //other buttons
                else{
                  return MyButton(
                    buttonTapped: () {
                      setState((){
                        userQuestion+=buttons[index];
                      });
                    },
                    color: isOperator(buttons[index])?Colors.deepPurple:Colors.deepPurple.shade50,
                    textColor: isOperator(buttons[index])?Colors.white:Colors.deepPurple,
                    buttonText: buttons[index],
                  );
                }

                },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x=="%" || x=="/" || x=="x" || x=="+" || x=="-"){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll("x", "*");
    //  Parse expression:
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    // Bind variables and evaluate the expression as real number.
    ContextModel cm = ContextModel();
    // (3) Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer=eval.toString();

  }

}

