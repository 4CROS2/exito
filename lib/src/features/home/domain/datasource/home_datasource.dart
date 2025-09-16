abstract interface class HomeDatasource {
  Future<List<Map<String, dynamic>>> getCategories();
}
