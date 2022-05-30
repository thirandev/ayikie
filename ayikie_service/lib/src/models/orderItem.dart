
class OrderItem{
  int customerId;
  int id;
  int method;
  String note;
  String location;
  double total;

  OrderItem(
      {required this.id,
        required this.customerId,
        required this.method,
        required this.note,
        required this.location,
        required this.total});

  @override
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      customerId: json['customer_id'],
      location: json['location'] == null ? "" : json['location'],
      total: double.parse(json['total']),
      method: json['method'],
      note: json['note']
    );
  }
}
