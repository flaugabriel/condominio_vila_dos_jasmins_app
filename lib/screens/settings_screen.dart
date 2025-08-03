// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Unidade: Casa 12 - Bloco A'),
            const SizedBox(height: 12),
            const Text('Titular: João da Silva'),
            const SizedBox(height: 12),
            const Text('Contato: (11) 98765-4321'),
            const Divider(height: 32),
            const Text('Alterar Senha', style: TextStyle(fontWeight: FontWeight.bold)),
            const TextField(
              decoration: InputDecoration(labelText: 'Senha atual'),
              obscureText: true,
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Nova senha'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Salvar nova senha'),
            ),
          ],
        ),
      ),
    );
  }
}