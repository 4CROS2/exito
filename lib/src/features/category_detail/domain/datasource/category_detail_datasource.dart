/// Contrato para la fuente de datos de productos por categoría.
abstract interface class CategoryDetailDatasource {
  /// Obtiene la lista de productos en formato mapa.
  Future<List<Map<String, dynamic>>> getProducts();
}
