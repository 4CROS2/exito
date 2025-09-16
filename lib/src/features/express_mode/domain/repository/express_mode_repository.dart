abstract interface class ExpressModeRepository  {
  Future<void> toggleExpressMode({required bool isEnabled});
  Future<bool> isExpressModeEnabled();
}