import 'dart:convert';

import 'package:exito/src/features/category_detail/domain/datasource/category_detail_datasource.dart';
import 'package:http/http.dart' as http;

class ICategoryDetailDatasource implements CategoryDetailDatasource {
  @override
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final String apiUrl = const String.fromEnvironment('API_URL');
      final http.Response response = await http.get(
        Uri.parse('$apiUrl/products'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception(
          'Error al obtener las categorías: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener las categorías: $e');
    }
  }
}
