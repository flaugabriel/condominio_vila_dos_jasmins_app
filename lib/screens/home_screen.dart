// lib/screens/payment_list_screen.dart
import 'dart:convert';
import 'package:condominio_vila_dos_jasmins_app/screens/payment/payment_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:condominio_vila_dos_jasmins_app/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/payment.dart';
import '../providers/session_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Payment> getPaidPayments(userId, token) async {
    final response = await PaymentProvider().fetchCurrentMonthPayment(
      userId,
      token,
    );

    // Se já for Map, retorne direto
    return Payment.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionProvider>(context, listen: false);
    final userId = session.user?['id'];
    final token = session.authHeaders!['Authorization']!;

    return Scaffold(
      body: FutureBuilder<Payment>(
        future: getPaidPayments(userId, token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListTile(
                tileColor: Colors.green[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Sem pendências',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                )
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Sem pagamentos agendados esse mês!', style: TextStyle(fontSize: 24),));
          } else {
          final payment = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.black, width: 2.0)),
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    '${payment.amount}',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailScreen(payment: payment),
                      ),
                    );
                  },
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text('Vencimento: ${payment.dueDate}', style: const TextStyle(color: Colors.black, fontSize: 23)),
                      Text("Desconto de 25%", style: const TextStyle(color: Colors.black, fontSize: 18))
                    ],
                  ),
                )
              ],
            ),
          );
          }
        },
      ),
    );
  }
}
