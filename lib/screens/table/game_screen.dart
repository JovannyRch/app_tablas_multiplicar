import 'package:flutter/material.dart';
import 'package:tablas_de_multiplicar/const/const.dart';
import 'package:tablas_de_multiplicar/models/answer_model.dart';

class GameScreen extends StatefulWidget {
  final int number;
  GameScreen(this.number);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int number;
  int current = 0;
  int corrects = 0;
  int incorrects = 0;
  bool isEnd = false;
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<Answer> answers = [];
  int _currentScreen = 0;
  bool isRandom = true;
  bool isWithOptions = true;

  @override
  void initState() {
    this.number = widget.number;
    super.initState();
    this.numbers.shuffle();
    this.getAnswers();
  }

  void getAnswers() {
    List<int> copyNumbers = [...this.numbers];
    answers.clear();
    answers.add(Answer(numbers[current] * number, isCorrect: true));
    copyNumbers.removeAt(current);
    copyNumbers.shuffle();
    for (int i = 0; i < 3; i++) {
      int x = copyNumbers[i];
      answers.add(Answer(x * number));
    }
    answers.shuffle();
    print(answers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyColor,
      body: SafeArea(
        child: IndexedStack(
          index: _currentScreen,
          children: <Widget>[
            _options(),
            _game(),
            _endGame(),
          ],
        ),
      ),
    );
  }

  Widget _endGame() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Fin del juego",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _options() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Configuración del juego",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 100.0,
            width: 200.0,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightGreen,
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text(
                "$number",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SwitchListTile(
            activeColor: Color(0xFFf5a31a),
            title: Text(
              "Desordenar",
              style: TextStyle(
                color: Color(0xffedf4f2),
                fontSize: 20.0,
              ),
            ),
            onChanged: (v) {
              setState(() {
                isRandom = v;
              });
            },
            value: isRandom,
          ),
          SwitchListTile(
            activeColor: Color(0xFFf5a31a),
            title: Text(
              "Con opciones",
              style: TextStyle(
                color: Color(0xffedf4f2),
                fontSize: 20.0,
              ),
            ),
            onChanged: (v) {
              setState(() {
                isWithOptions = v;
              });
            },
            value: isWithOptions,
          ),
          SizedBox(height: 20.0),
          _buttonStart(),
        ],
      ),
    );
  }

  Widget _buttonStart() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentScreen = 1;
        });
      },
      child: Container(
        height: 60.0,
        width: 270.0,
        decoration: BoxDecoration(
          color: Color(0xFFf5a31a),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            "Iniciar Juego",
            style: TextStyle(
              fontSize: 30.0,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _game() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _display(),
          _drawAnswers(),
        ],
      ),
    );
  }

  Widget _drawAnswers() {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _button(answers[0]),
                _button(answers[1]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _button(answers[2]),
                _button(answers[3]),
              ],
            )
          ],
        ));
  }

  Widget _displayInfo() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _iconData(
            Icon(
              Icons.check,
              color: Color(0xFF436f8a),
            ),
            corrects,
          ),
          _iconData(
            Icon(
              Icons.cancel,
              color: Color(0xFFd32626),
            ),
            incorrects,
          )
        ],
      ),
    );
  }

  Widget _iconData(Icon icon, int data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            "$data",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 5.0),
          icon,
        ],
      ),
    );
  }

  Widget _button(Answer a) {
    return GestureDetector(
      onTap: () {
        if (a.isCorrect) {
          corrects++;
        } else {
          incorrects++;
        }

        if (current + 1 == numbers.length) {
          isEnd = true;
          _currentScreen = 2;
          _endGame();
        } else {
          current++;
          getAnswers();
        }
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        width: 100.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Color(0xFFf5a31a),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: Text(
          "${a.value}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        )),
      ),
    );
  }

  Widget _display() {
    var question = Container(
      height: 100.0,
      width: 200.0,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.lightGreen,
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Text(
          _buildQuestion(),
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Column(
      children: <Widget>[
        _displayInfo(),
        question,
      ],
    );
  }

  String _buildQuestion() {
    int current = this.numbers[this.current];
    return "$number x $current";
  }
}
