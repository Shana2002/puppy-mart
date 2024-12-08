class CapitalizeText {
  String text;
  CapitalizeText({required this.text});
  String capitalize() {
    if (text.isEmpty) {
      return text;
    } else {
      return text[0].toUpperCase() + text.substring(1);
    }
  }
}
