import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:condominio_vila_dos_jasmins_app/providers/session_provider.dart';
import 'package:condominio_vila_dos_jasmins_app/screens/login_screen.dart';
import 'package:condominio_vila_dos_jasmins_app/screens/main_menu_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega o arquivo .env
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (_) => SessionProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // ou en, etc.
      ],
      title: 'Vila dos Jasmins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      // main.dart (trecho das rotas)
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MainMenuScreen(), // 👈 aqui está a rota
        // outras rotas como:
        // '/faturas': (context) => FaturasScreen(),
        // '/configuracoes': (context) => ConfigScreen(),
      },
    );
  }
}
