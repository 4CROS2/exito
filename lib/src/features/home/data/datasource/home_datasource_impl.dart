import 'dart:convert';

import 'package:exito/src/features/home/domain/datasource/home_datasource.dart';
import 'package:http/http.dart' as http;

class IHomeDatasource implements HomeDatasource {
  final String apiUrl = const String.fromEnvironment('API_URL');
  @override
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final http.Response response = await http.get(
        Uri.parse('$apiUrl/products'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Error: ${response.statusCode}');
        throw Exception(
          'Error al obtener las categorías: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener las categorías: $e');
    }
  }
}
