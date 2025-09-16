import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppProvider>(() => AppProvider());
  sl.registerFactory<HomeProvider>(() => HomeProvider());
}
