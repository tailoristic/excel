import 'dart:convert';

String url = "https://raw.githubusercontent.com/tailoristic/jsonT/main/db.json";
List<Welcome> welcomeFromJson(url) =>
    List<Welcome>.from(json.decode(url).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.id,
    this.city,
  });

  String id;
  String city;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };
}
