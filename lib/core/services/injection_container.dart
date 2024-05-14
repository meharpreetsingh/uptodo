import 'package:get_it/get_it.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:uptodo/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';
import 'package:uptodo/features/auth/domain/usecases/login_user.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

/// Initialize the service locator
void initGetIt() {
  getIt.registerSingleton<GoRouterProvider>(GoRouterProvider());

  getIt
    ..registerFactory(() => AuthBloc())
    ..registerLazySingleton(() => RegisterUser(getIt()))
    ..registerLazySingleton(() => LoginUser(getIt()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))..registerLazySingleton<AuthRemoteDataSource>(() => )..registerLazySingleton(() => null);
}

// globalBloc
// { Inherited Wrapper }
