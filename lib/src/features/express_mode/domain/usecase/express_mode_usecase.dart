import 'package:exito/src/features/express_mode/domain/repository/express_mode_repository.dart';

class ExpressModeUsecase {
  ExpressModeUsecase({required ExpressModeRepository repository})
    : _repository = repository;
  final ExpressModeRepository _repository;

  Future<void> toggleExpressMode({required bool isEnabled}) async =>
      _repository.toggleExpressMode(isEnabled: isEnabled);

  Future<bool> isExpressModeEnabled() async =>
      _repository.isExpressModeEnabled();
}
