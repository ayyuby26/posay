class Helper {
  static double dotRemover(String number, String currency) {
    final x = currency == "usd" ? number : number.replaceAll(".", "");
    return double.parse(x);
  }
}
