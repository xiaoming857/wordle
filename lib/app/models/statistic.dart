class Statistic {
  late final List<String> elapsedTime;
  late final bool isSuccess;
  late final int numOfGuesses;
  late final String wordOfTheDay;

  Statistic(
    this.elapsedTime,
    this.isSuccess,
    this.numOfGuesses,
    this.wordOfTheDay,
  );

  Statistic.fromJson(Map<String, dynamic> json)
      : this(
          json['wordOfTheDay'],
          json['isSuccess'],
          json['numOfGuesses'],
          json['elapsedTime'],
        );

  Map<String, dynamic> get toMap {
    final map = <String, dynamic>{};
    map['wordOfTheDay'] = wordOfTheDay;
    map['isSuccess'] = isSuccess;
    map['numOfGuesses'] = numOfGuesses;
    map['elapsedTime'] = elapsedTime;
    return map;
  }
}
