import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Vote.dart';


class Question {
  int id;
  String text;
  List<Vote> votes;

  Question(String text) {
    this.text = text;
    this.votes = new List<Vote>();
  }
}

class QuestionWidget extends StatelessWidget {
  Question question;
  Voting voting;

  QuestionWidget(Question question) {
    this.question = question;
    voting = new Voting(question.votes);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: new EdgeInsets.all(5),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(11)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(children: <Widget>[
          voting,
          Align(
              alignment: Alignment.centerLeft,
              child: Text(question.text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        ]),
      ),
      onTap: questionMenu,
    );
  }
}

class Voting extends StatefulWidget {
  List<Vote> votes;
  int upvoteCount, downvoteCount;

  Voting(List<Vote> votes) {
    this.votes = votes;
  }

  @override
  _VotingState createState() => new _VotingState();
}

class _VotingState extends State<Voting> {
  int _upvoteCount = 0;
  int _downvoteCount = 0;

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_up),
            onPressed: () => setState(() => _upvoteCount++)),
      ),
      Text((_upvoteCount - _downvoteCount).toString(),
          style: TextStyle(color: Colors.black)),
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_down),
            onPressed: () => setState(() => _downvoteCount++)),
      ),
    ]);
  }
}

class QuestionListState extends State<QuestionList> {
  TextEditingController questionController = new TextEditingController();

  List<Question> questions = [
    new Question("Primeira"),
    new Question("Segunda")
  ];

  void addQuestion(String question) {
    if (question != "")
      setState(() {
        questions.add(new Question(question));
      });
  }

  List<Widget> getTextWidgets() {
    List<Widget> list = [];
    for (int i = 0; i < questions.length; i++)
      list.add(QuestionWidget(questions[i]));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFocusNode = new FocusNode();
    return Stack(children: [
      FractionallySizedBox(
        heightFactor: 0.87,
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            children: getTextWidgets()),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10),
            child: TextField(
              focusNode: textFocusNode,
              controller: questionController,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: 'Enter your question',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      textFocusNode.unfocus();
                      textFocusNode.canRequestFocus=false;
                      addQuestion(questionController.text);
                      questionController.clear();
                      Future.delayed(Duration(milliseconds: 100), () {
                        textFocusNode.canRequestFocus = true;
                      });
                    },
                  )
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class QuestionList extends StatefulWidget {
  @override
  QuestionListState createState() => new QuestionListState();
}

void questionMenu() {
  print("I was called\n");
  return;
}
