import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String UserInput = "";
  String Result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[350],
       body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(UserInput, style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    Result, style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                )
              ],
            ),
          ),
          const Divider(color: Colors.white,),
          Expanded(child: Container(
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: buttonList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (BuildContext context, int index) {
                return  CustomButton(buttonList[index]);
              }
            ),
            ))
        ],
       ),
    );
    
}
Widget CustomButton(String text){
  return InkWell(
    // splashColor: Color(0xFF1d2630),
    splashColor: Colors.orange,
    onTap: () {
      setState(() {
        handleButtons(text);
      });
    },
    child: Ink(
      decoration: BoxDecoration(
        color: getBgColor(text), 
        borderRadius: BorderRadius.circular(10),
        boxShadow:const [
        BoxShadow(
          color: Colors.white,
          blurRadius: 4,
          spreadRadius: 0.5,
          offset: Offset(-3, 3),
          ) ],
      ),
      child: Center(child: Text(
        text , style: TextStyle(
          color: getColor(text),
        fontSize: 30, fontWeight: FontWeight.bold
      ),)),
    ),
  );
}
getColor(String text){
  if(text == "/"||text == "*"||text == "+"||text == "C "||text == "("||text == ")"||text == "-"){
    return Color.fromARGB(255, 215, 100, 100);
  }
  return Colors.white;
}
getBgColor(text){
  if(text == "AC"|| text == "C"){
    return Color.fromARGB(255, 215, 100, 100);
  }
  
  if(text=="="){return Color.fromARGB(255, 104, 215, 109);}
  return Colors.grey;
}
handleButtons(String text){
  if(text =="AC"){
    UserInput = "";
     Result = "0";
     return;
  }
  if(text == "C"){
   if(UserInput.isNotEmpty){
    UserInput= UserInput.substring(0, UserInput.length-1);
    return;
   }
   else {return null;
   }
  }
 if(text == "="){
    Result = calculate();
    UserInput =Result;

  if(Result.endsWith(".0")){
      Result = Result.replaceAll(".0", "");
      return;
    }
    if(UserInput.endsWith(".0")){
      UserInput = UserInput.replaceAll(".0", "");
      return;
    }

    
  }
  

  UserInput = UserInput + text;

} 
String calculate(){
try{
  var exp = Parser().parse(UserInput);
  var evalution = exp.evaluate(EvaluationType.REAL, ContextModel());
  return evalution.toString();
}
catch(e){
  return "ERROR"; 
}
}
}