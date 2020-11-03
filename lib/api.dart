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
