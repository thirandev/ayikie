class States {
  String state;

  States({
    required this.state,
  });

  @override
  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      state: json['state'],
    );
  }
}

class Cities{
  int id;
  String country;
  String state;
  String city;

  Cities({
    required this.id,
    required this.city,
    required this.country,
    required this.state,
  });

  @override
  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'],
      city: json['city'],
      country: json['country'],
      state: json['state'],
    );
  }
}
