import 'package:exito/src/features/express_mode/domain/datasource/express_mode_datasource.dart';
import 'package:exito/src/features/express_mode/domain/repository/express_mode_repository.dart';

class IExpressModeRepository implements ExpressModeRepository {
  IExpressModeRepository({required ExpressModeDatasource datasource})
    : _datasource = datasource;
  final ExpressModeDatasource _datasource;

  @override
  Future<bool> isExpressModeEnabled() async {
    return await _datasource.isExpressModeEnabled();
  }

  @override
  Future<void> toggleExpressMode({required bool isEnabled}) async {
    await _datasource.toggleExpressMode(isEnabled: isEnabled);
  }
}
