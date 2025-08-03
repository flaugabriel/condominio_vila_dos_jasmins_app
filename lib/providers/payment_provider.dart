import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/payment.dart';
import '../models/user.dart';

class PaymentProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL'] ?? 'http://201.23.65.16:3030',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<User> fetchPaymentsForResident(int userId, String authorization) async {
    final response = await _dio.get(
      '/api/users/$userId',
      options: Options(
        headers: {
          'Authorization': authorization,
        },
      ),
    );

    // Certifique-se de que `response.data` é Map<String, dynamic>
    return User.fromJson(response.data);
  }

  fetchCurrentMonthPayment(int userId, String authorization) async {
    final response = await _dio.get(
      '/api/payments/month/current/$userId',
      options: Options(
        headers: {
          'Authorization': authorization,
        },
      ),
    );

    // Certifique-se de que `response.data` é Map<String, dynamic>
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<Payment?>  fetchLastPayments(int userId, String authorization) async {
    final response = await _dio.get(
      '/api/payments/last/by/month/$userId',
      options: Options(
        headers: {
          'Authorization': authorization,
        },
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.data);
      return Payment.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
