class ListviewHelper {
  static String limitText(text, limit) =>
      (text.length >= limit) ? text.substring(0, text) + "..." : text;
}
