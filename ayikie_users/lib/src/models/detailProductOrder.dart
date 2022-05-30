class DetailProductOrder {
  int orderId;
  int customerId;
  double total;
  String createdAt;
  int status;
  int method;
  String trackingNo;
  String location;
  String note;

  DetailProductOrder({
    required this.orderId,
    required this.customerId,
    required this.total,
    required this.createdAt,
    required this.status,
    required this.method,
    required this.location,
    required this.trackingNo,
    required this.note
  });

  @override
  factory DetailProductOrder.fromJson(Map<String, dynamic> json) {
    return DetailProductOrder(
      orderId: json['id'],
      customerId: json['customer_id'],
      method: json['method'],
      total: double.parse(json['total']),
      status: json['status'],
      createdAt: json['created_at'],
      note: json['note'] == null ? "-" : json['note'],
      trackingNo: json['ref_no'] == null ? "-" : json['ref_no'],
      location: json['location'] == null ? "-" : json['location'],
    );
  }
}
