import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SessionProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  Map<String, dynamic>? user;
  Map<String, String> authHeaders = {};

  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://201.23.65.16:3030',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<bool> login({required String cpf_cnpj, required String password}) async {
    try {
      final response = await _dio.post('/api/auth/sign_in', data: {
        'cpf_cnpj': cpf_cnpj,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Captura os headers de autenticação necessários
        authHeaders = {
          'Authorization': response.headers.value('Authorization') ?? '',
          'access-token': response.headers.value('access-token') ?? '',
          'client': response.headers.value('client') ?? '',
          'uid': response.headers.value('uid') ?? '',
        };

        // Salva os dados do usuário
        user = response.data['data']; // <- importante: é 'data', não 'user'
        isAuthenticated = true;
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      print('Erro no login: ${e.response?.data ?? e.message}');
    }
    return false;
  }

  void logout() {
    isAuthenticated = false;
    user = null;
    authHeaders = {};
    notifyListeners();
  }

  /// Método auxiliar para chamadas autenticadas futuras
  Dio get authedDio {
    return Dio(BaseOptions(
      baseUrl: dotenv.env['API_URL'] ?? 'http://201.23.65.16:3030',
      headers: {
        'Content-Type': 'application/json',
        ...authHeaders,
      },
    ));
  }
}
