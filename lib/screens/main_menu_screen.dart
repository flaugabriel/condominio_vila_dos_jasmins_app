// lib/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../screens/payment/payment_list_screen.dart';
import 'config_screen.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    PaymentListScreen(),
    ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionProvider>(context);
    final user = session.user;
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Menu principal' : 'Faturas',
          style: const TextStyle(color: Colors.black),
        ),

        backgroundColor: Colors.white,
        elevation: 8.6, // quanto maior, mais forte a sombra
        shadowColor: Colors.black.withOpacity(0.5), // cor da sombra
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Faturas',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Configurações',
          // ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
