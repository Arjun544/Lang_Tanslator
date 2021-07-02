class LangModel {
  String from;
  String to;

  LangModel(this.from, this.to);

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'from': from,
    };
  }

  LangModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }
}
