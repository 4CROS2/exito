abstract interface class ExpressModeDatasource {
  Future<void> toggleExpressMode({required bool isEnabled});
  Future<bool> isExpressModeEnabled();
}
