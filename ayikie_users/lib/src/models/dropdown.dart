class Dropdown {
  int id;
  String name;

  Dropdown({required this.id, required this.name});

  factory Dropdown.fromJson(Map<String, dynamic> json) {
    return Dropdown(
      id: json['id'],
      name: json['name'],
    );
  }
}