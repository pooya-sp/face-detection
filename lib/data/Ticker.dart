class Ticker {
  Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) {
      return ticks + x + 1;
    });
  }
}
