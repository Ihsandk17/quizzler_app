import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart'; //quiz_brain is a separate file where i have created class and methods

QuizBrain quizBrain =
    QuizBrain(); //object creation of QuizBrain which is a question bank class

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = []; //list of icons
  void checkAnswer(bool userPikedAnswer) //mehtod
  {
    bool correctanswer = quizBrain.getCorrectAnswer();
    setState(() // setState is a method which used for reloding after every step
        {
      if (quizBrain.isFinished() == true) {
        Alert(context: context, title: "FINISHED", desc: "quiz has end.")
            .show(); // Alert and popup message desplaying at the end of quize
        quizBrain
            .reset(); // reset the answers "quizBrain" is an object and rest() is a mehtod of Quizbrain class
        scorekeeper =
            []; //scorekeeper is a list of icons here this line means icons resets
      } else {
        if (userPikedAnswer == correctanswer) {
          scorekeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scorekeeper.add(const Icon(Icons.close, color: Colors.red));
        }
        quizBrain
            .nextQuestion(); // quizBrain is an object and nextQuestion is a method of QuizBrain class
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ), //row this we have used to show icons in row form
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            // ignore: deprecated_member_use
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(
                    true); // method calling, checkAnswer is a method who check the answer is true or fals and also show the icons
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            // ignore: deprecated_member_use
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
