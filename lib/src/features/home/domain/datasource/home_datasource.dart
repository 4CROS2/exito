abstract interface class HomeDatasource {
  Future<List<Map<String, String>>> getCategories();
}