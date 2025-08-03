// lib/screens/invoices_screen.dart
import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faturas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Filtrar por mês'),
              items: ['Maio/2025', 'Abril/2025', 'Março/2025']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text('Maio/2025'),
                    subtitle: Text('R\$ 600,00 - Pendente'),
                    trailing: Icon(Icons.warning, color: Colors.orange),
                  ),
                  ListTile(
                    title: Text('Abril/2025'),
                    subtitle: Text('R\$ 600,00 - Pago'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}