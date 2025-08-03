class Payment {
  final int? id;
  final int? residentId;
  final String amount;
  final String dueDate;
  final String status;
  final String? paymentDate;
  final String? description;
  final String? residentHomeNumber;
  final String? invoiceUrl;

  Payment({
    required this.id,
    required this.residentId,
    required this.amount,
    required this.description,
    required this.invoiceUrl,
    required this.dueDate,
    required this.residentHomeNumber,
    required this.status,
    this.paymentDate
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      residentId: json['resident_id'],
      amount: json['amount'],
      dueDate: json['due_date'],
      residentHomeNumber: json['resident_home_number']?.toString(),
      status: json['status'],
      description: json['description'],
      paymentDate: json['payment_date'],
      invoiceUrl: json['invoice_url'],
    );
  }
}
