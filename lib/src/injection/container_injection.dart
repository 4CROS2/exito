import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/features/home/data/datasource/home_datasource_impl.dart';
import 'package:exito/src/features/home/data/repository/home_repository_impl.dart';
import 'package:exito/src/features/home/domain/datasource/home_datasource.dart';
import 'package:exito/src/features/home/domain/repository/home_repository.dart';
import 'package:exito/src/features/home/domain/usecase/home_usecase.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Datasource
  sl.registerLazySingleton<HomeDatasource>(() => IHomeDatasource());

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => IHomeRepository(datasource: sl<HomeDatasource>()),
  );

  //usecases
  sl.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(repository: sl<HomeRepository>()),
  );

  // Providers
  sl.registerLazySingleton<AppProvider>(() => AppProvider());
  sl.registerFactory<HomeProvider>(
    () => HomeProvider(usecase: sl<HomeUsecase>()),
  );
}
