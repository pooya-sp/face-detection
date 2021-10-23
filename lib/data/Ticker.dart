class Ticker {
  Ticker();
  Stream<int> countUp({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks + x + 1);
  }

  Stream<int> countDown({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
