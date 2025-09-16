import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/features/cart/data/datasource/cart_datasource_impl.dart';
import 'package:exito/src/features/cart/data/repository/cart_repository_impl.dart';
import 'package:exito/src/features/cart/domain/datasource/cart_datasource.dart';
import 'package:exito/src/features/cart/domain/repository/cart_repository.dart';
import 'package:exito/src/features/cart/domain/usecase/cart_usecase.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/category_detail/data/datasource/category_detail_datasource_impl.dart';
import 'package:exito/src/features/category_detail/data/repository/category_detail_repository_impl.dart';
import 'package:exito/src/features/category_detail/domain/datasource/category_detail_datasource.dart';
import 'package:exito/src/features/category_detail/domain/repository/category_detail_repository.dart';
import 'package:exito/src/features/category_detail/domain/usecase/category_detail_usecase.dart';
import 'package:exito/src/features/category_detail/presentation/bloc/category_detail_provider.dart';
import 'package:exito/src/features/express_mode/data/datasource/express_mode_datasource_impl.dart';
import 'package:exito/src/features/express_mode/data/repository/express_mode_repository_impl.dart';
import 'package:exito/src/features/express_mode/domain/datasource/express_mode_datasource.dart';
import 'package:exito/src/features/express_mode/domain/repository/express_mode_repository.dart';
import 'package:exito/src/features/express_mode/domain/usecase/express_mode_usecase.dart';
import 'package:exito/src/features/express_mode/presentation/bloc/express_mode_provider.dart';
import 'package:exito/src/features/home/data/datasource/home_datasource_impl.dart';
import 'package:exito/src/features/home/data/repository/home_repository_impl.dart';
import 'package:exito/src/features/home/domain/datasource/home_datasource.dart';
import 'package:exito/src/features/home/domain/repository/home_repository.dart';
import 'package:exito/src/features/home/domain/usecase/home_usecase.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

/// Inicializa e inyecta todas las dependencias principales de la aplicación.
///
/// Registra datasources, repositorios, casos de uso y providers usando GetIt.
Future<void> init() async {
  // Datasource
  sl.registerLazySingleton<HomeDatasource>(() => IHomeDatasource());
  sl.registerLazySingleton<CategoryDetailDatasource>(
    () => ICategoryDetailDatasource(),
  );
  sl.registerLazySingleton<CartDatasource>(() => ICartDatasource());
  sl.registerLazySingleton<ExpressModeDatasource>(
    () => IExpressModeDatasource(),
  );

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => IHomeRepository(datasource: sl<HomeDatasource>()),
  );
  sl.registerLazySingleton<CategoryDetailRepository>(
    () => ICategoryDetailRepository(datasource: sl<CategoryDetailDatasource>()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => ICartRepository(datasource: sl<CartDatasource>()),
  );
  sl.registerLazySingleton<ExpressModeRepository>(
    () => IExpressModeRepository(datasource: sl<ExpressModeDatasource>()),
  );

  //usecases
  sl.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(repository: sl<HomeRepository>()),
  );
  sl.registerLazySingleton<CategoryDetailUsecase>(
    () => CategoryDetailUsecase(repository: sl<CategoryDetailRepository>()),
  );
  sl.registerLazySingleton<CartUseCase>(
    () => CartUseCase(repository: sl<CartRepository>()),
  );
  sl.registerLazySingleton<ExpressModeUsecase>(
    () => ExpressModeUsecase(repository: sl<ExpressModeRepository>()),
  );

  // Providers
  sl.registerLazySingleton<AppProvider>(() => AppProvider());
  sl.registerFactory<HomeProvider>(
    () => HomeProvider(usecase: sl<HomeUsecase>()),
  );
  sl.registerFactory<CategoryDetailProvider>(
    () => CategoryDetailProvider(usecase: sl<CategoryDetailUsecase>()),
  );
  sl.registerLazySingleton<CartProvider>(
    () => CartProvider(cartUseCase: sl<CartUseCase>()),
  );
  sl.registerLazySingleton<ExpressModeProvider>(
    () => ExpressModeProvider(usecase: sl<ExpressModeUsecase>()),
  );
}
