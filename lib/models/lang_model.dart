class LangModel {
  String from;
  String to;

  LangModel(this.from, this.to);

  Map toMap() {
    return {
      'to': to,
      'from': from,
    };
  }
}
