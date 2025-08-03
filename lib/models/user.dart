import '../models/payment.dart';

class User {
  final int id;
  final String email;
  final String? name;
  final String status;
  final String resident;
  final String idAssas;
  final List<Payment> payments;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.status,
    required this.resident,
    required this.idAssas,
    required this.payments,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      status: json['status'],
      idAssas: json['id_assas'],
      resident: json['resident'], // ou json['resident']['name'] se vier como objeto
      payments: (json['payments'] as List)
          .map((v) => Payment.fromJson(v))
          .toList(),
    );
  }
}
