class Answer {
  int value;
  bool isCorrect;

  Answer(this.value, {this.isCorrect = false});
  @override
  String toString() {
    return "$value => $isCorrect";
  }
}
