// lib/screens/payment_list_screen.dart
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../providers/payment_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import 'package:intl/intl.dart';
import '../../models/payment.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../screens/payment/payment_detail_screen.dart';

class PaymentListScreen extends StatefulWidget {
  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}
class _PaymentListScreenState extends State<PaymentListScreen> {
  late Future<User> _paymentsFuture;
  DateTime? _filterDate;

  @override
  void initState() {
    super.initState();
    final session = Provider.of<SessionProvider>(context, listen: false);
    final userId = session.user?['id'];
    final token = session.authHeaders!['Authorization']!;
    _paymentsFuture = PaymentProvider().fetchPaymentsForResident(userId, token);
  }

  Future<void> _selectFilterDate() async {
    final now = DateTime.now();
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _filterDate ?? now,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 5),
    );

    if (selected != null) {
      setState(() {
        _filterDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: _selectFilterDate,
            tooltip: 'Filtrar por data de vencimento',
          ),
          if (_filterDate != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _filterDate = null;
                });
              },
              tooltip: 'Limpar filtro',
            ),
        ],
      ),
      body: FutureBuilder<User>(
        future: _paymentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar faturas, entre em contato com administrador'));
          } else if (!snapshot.hasData || snapshot.data!.payments.isEmpty) {
            return Center(child: Text('Nenhuma fatura encontrada'));
          }

          final user = snapshot.data!;
          List<Payment> payments = user.payments;
          final formatter = NumberFormat("#,##0.00", "pt_BR");

          // Filtra pela data se _filterDate estiver setada
          if (_filterDate != null) {
            payments = payments.where((p) {
              final dueDate = DateTime.tryParse(p.dueDate);
              if (dueDate == null) return false;
              // Compara só mês e ano
              return dueDate.year == _filterDate!.year &&
                  dueDate.month == _filterDate!.month;
            }).toList();
          }

          if (payments.isEmpty) {
            return Center(child: Text('Nenhuma fatura encontrada para a data selecionada'));
          }

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final p = payments[index];
              final paymentDateFormatted = (p.paymentDate != null && p.paymentDate!.isNotEmpty)
                  ? dateFormatter.format(DateTime.parse(p.paymentDate!))
                  : 'Sem data';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentDetailScreen(payment: p),
                    ),
                  );
                },
                child: Card(
                  color: p.status == 'paid' ? Colors.green : Colors.yellowAccent,
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.black, width: 2.0)),
                  child: ListTile(
                    leading:    Text(
                             'R\$ ${formatter.format(double.parse(p.amount))}',
                             style: TextStyle(fontSize: 18, color: p.status == 'paid' ? Colors.white : Colors.black),
                           ),
                    title: Text(
                      'Vencimento: ${dateFormatter.format(DateTime.parse(p.dueDate))}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: p.status == 'paid' ? Colors.white : Colors.black),
                    ),
                    subtitle:  Text(' ${p.status == 'paid' ? 'Pago' : 'Aberto'}', style: TextStyle(color: p.status == 'paid' ? Colors.white : Colors.black,fontSize: 18)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}