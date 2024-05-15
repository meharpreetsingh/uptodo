import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:uptodo/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';
import 'package:uptodo/features/auth/domain/usecases/login_user.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

/// Initialize the service locator
Future<void> initGetIt() async {
  sl.registerSingleton<GoRouterProvider>(GoRouterProvider());

  // Features - Auth
  sl.registerFactory<AuthBloc>(() => AuthBloc(loginUser: sl(), registerUser: sl())); // Presentation
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl())); // Usecase
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl())); // Usecase
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl())); // Repository
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl()); // Data source
}