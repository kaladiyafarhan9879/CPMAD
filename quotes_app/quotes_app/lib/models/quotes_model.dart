import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  final String q; // Quote text
  final String a; // Author name
  final String h; // HTML representation

  Quotes({required this.q, required this.a, required this.h});

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
    q: json["q"] ?? json["quote"] ?? '',
    a: json["a"] ?? json["author"] ?? 'Unknown',
    h: json["h"] ?? '',
  );

  Map<String, dynamic> toJson() => {"q": q, "a": a, "h": h};
}
