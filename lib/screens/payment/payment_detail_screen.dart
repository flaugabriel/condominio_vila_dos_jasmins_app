// lib/screens/payment/payment_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/payment.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailScreen extends StatelessWidget {
  final Payment payment;

  const PaymentDetailScreen({super.key, required this.payment});


  String getStatusMensagem(String? status) {
    if (status == 'late') {
      return 'Atrasado';
    } else if (status == 'paid') {
      return 'Pago';
    } else if (status == 'open') {
      return 'Aberto';
    } else if (status == null) {
      return 'Existe um problema no pagamento, entre em contato com o administrador';
    } else {
      return 'Existe um problema no pagamento, entre em contato com o administrador';
    }
  }


  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(payment.invoiceUrl.toString());
    final isPaid = payment.status == 'paid';
    final dateFormatter = DateFormat('dd/MM/yyyy');
    print(payment.status);
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Detalhes da Fatura', style: TextStyle(color: Colors.white, fontSize: 28)),backgroundColor: Colors.grey[900]),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'DETALHE DE PAGAMENTO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            _buildLine('ID Fatura:', payment.id.toString()),
            _buildLine('Status:', getStatusMensagem(payment.status)),
            _buildLine('Vencimento:', dateFormatter.format(DateTime.parse(payment.dueDate!))),
            _buildLine(
              'Data de Pagamento:',
              payment.paymentDate == null ? 'Não pago ainda' : dateFormatter.format(DateTime.parse(payment.dueDate!))),
            _buildLine(
              'Valor:',
              'R\$ ${payment.amount} (25% de desconto até dia 10)',
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Colors.black12),
            const SizedBox(height: 12),
            if (!isPaid)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Abriria o link de pagamento:\n${payment.invoiceUrl}',
                      ),
                    ),
                  );
                  _launchUrl();
                },
                child: const Text(
                  'REALIZAR PAGAMENTO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const Text(
                'Pagamento confirmado.',
                style: TextStyle(

                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 12),
            const Divider(thickness: 1, color: Colors.black12),
            const SizedBox(height: 8),
            const Text(
              'Obrigado por manter seu condomínio em dia!',
              style: TextStyle(fontSize: 18),
            ),
          ],
                ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(25.0),
      //   child:  Padding(
      //       padding: const EdgeInsets.all(25.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         // children: [
      //         //   Text('Número de identificação da fatura: ${payment.id}', style: TextStyle(fontSize: 18),),
      //         //   SizedBox(height: 10),
      //         //   Text('Vencimento: ${payment.dueDate}' , style: TextStyle(fontSize: 24),),
      //         //   SizedBox(height: 10),
      //         //   Text('Status: ${payment.status == 'paid' ? 'Pago' : 'Aberto'}' , style: TextStyle(fontSize: 24),),
      //         //   SizedBox(height: 10),
      //         //   Text(payment.paymentDate == null ? 'não pago' : 'Data de Pagamento:${ payment.paymentDate}', style: TextStyle(fontSize: 24),),
      //         //   SizedBox(height: 10),
      //         //   Text('R\$ ${payment.amount} pagando até o dia 10 com desconto de 25%', style: TextStyle(fontSize: 24),),
      //         //   SizedBox(height: 10),
      //         //   payment.status == 'paid' ?
      //         //   Spacer()
      //         //    : Center(
      //         //     child: ElevatedButton(
      //         //       style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
      //         //       onPressed: _launchUrl,
      //         //       child: Text('REALIZAR PAGAMENTO', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
      //         //     ),
      //         //   )
      //         // ],
      //       ),
      //   ),
      // ),
    );
  }


  Widget _buildLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
