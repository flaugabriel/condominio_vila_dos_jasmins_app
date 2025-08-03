// lib/screens/login_screen.dart
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _cpfCnpjController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final session = Provider.of<SessionProvider>(context, listen: false);
    final success = await session.login(
      cpf_cnpj: UtilBrasilFields.removeCaracteres(_cpfCnpjController.text),
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao fazer login')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffbdbdbd),
      body: SafeArea(child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(child: Text("Olá, seja bem vindo!", style: TextStyle(color: Color(
              0xFFFFFFFF),fontSize: 20,fontWeight: FontWeight.bold),),),),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              clipBehavior: Clip.hardEdge, // Necessário para cortar a imagem no raio
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),child: Column(
            children: [
              TextField(
                controller: _cpfCnpjController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  labelStyle: TextStyle(
                    color: Color(0xFF111518),
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: 'Insira seu CPF',
                  hintStyle: TextStyle(color: Color(0xFF60768A)),
                  filled: true,
                  fillColor: Color(0xFFF0F2F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20)
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              SizedBox(height: 16,),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Color(0xFF111518),
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: 'Insira sua senha',
                  filled: true,
                  fillColor: Color(0xFFF0F2F5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20)
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF24700A),
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            Center(
                          child: Column(
                            children: [
                              Icon(Icons.lock_outline, size: 20, color: Colors.black54),
                              SizedBox(height: 4),
                              Text(
                                'Ambiente protegido',
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              Text(
                                'Desenvolvido com 💚',
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        )
            ],
          ),)
        ],
      )),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(24.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           // 🔰 Logo do condomínio
      //           Image.asset(
      //             'assets/logo.jpg', // ajuste o caminho conforme necessário
      //             height: 120,
      //           ),
      //           const SizedBox(height: 24),
      //
      //           // 👋 Saudações
      //           const Align(
      //             alignment: Alignment.centerLeft,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Olá, Bem vindo!',
      //                   style: TextStyle(
      //                     fontSize: 28,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 SizedBox(height: 8),
      //                 Text(
      //                   'Estamos felizes em te ver!',
      //                   style: TextStyle(fontSize: 16, color: Colors.white),
      //                 ),
      //               ],
      //             ),
      //           ),
      //
      //           const SizedBox(height: 32),
      //
      //           // 📧 Email
      //           const Align(
      //             alignment: Alignment.centerLeft,
      //             child: Text('Digite seu CPF ou CNPJ', style: TextStyle(color: Colors.white)),
      //           ),
      //           TextField(
      //             controller: _cpfCnpjController,
      //             keyboardType: TextInputType.emailAddress,
      //               inputFormatters: [
      //                 FilteringTextInputFormatter.digitsOnly,
      //                 CpfInputFormatter(),
      //               ],
      //             decoration: const InputDecoration(
      //               suffixIcon: Icon(Icons.check_circle, color: Colors.white),
      //               enabledBorder: UnderlineInputBorder(
      //                 borderSide: BorderSide(color: Colors.white),
      //               ),
      //             ),
      //           ),
      //
      //           const SizedBox(height: 16),
      //
      //           // 🔒 Senha
      //           const Align(
      //             alignment: Alignment.centerLeft,
      //             child: Text('Digite sua senha', style: TextStyle(color: Colors.white)),
      //           ),
      //           TextField(
      //             controller: _passwordController,
      //             obscureText: true,
      //             decoration: const InputDecoration(
      //               suffixIcon: Icon(Icons.lock, color: Colors.white),
      //               enabledBorder: UnderlineInputBorder(
      //                 borderSide: BorderSide(color: Colors.white),
      //               ),
      //             ),
      //           ),
      //
      //           const SizedBox(height: 32),
      //
      //           // ✅ Botão de login
      //           SizedBox(
      //             width: double.infinity,
      //             height: 50,
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: const Color(0xFF45b3b4),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(10),
      //                 ),
      //               ),
      //               onPressed: () => _login(context),
      //               child: const Text(
      //                 'ENTRAR',
      //                 style: TextStyle(fontSize: 16, color: Colors.white),
      //               ),
      //             ),
      //           ),
      //
      //           const SizedBox(height: 24),
      //
      //           // 🔐 Rodapé
      //           const Center(
      //             child: Column(
      //               children: [
      //                 Icon(Icons.lock_outline, size: 20, color: Colors.black54),
      //                 SizedBox(height: 4),
      //                 Text(
      //                   'Ambiente protegido',
      //                   style: TextStyle(fontSize: 12, color: Colors.black54),
      //                 ),
      //                 Text(
      //                   'Desenvolvido com 💚',
      //                   style: TextStyle(fontSize: 12, color: Colors.black54),
      //                 ),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
