import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:uptodo/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';
import 'package:uptodo/features/auth/domain/usecases/login_user.dart';
import 'package:uptodo/features/auth/domain/usecases/logout_user.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/theme/data/data_sources/theme_local_data_source.dart';
import 'package:uptodo/features/theme/data/repository_impl/theme_repo_impl.dart';
import 'package:uptodo/features/theme/domain/repository/theme_repo.dart';
import 'package:uptodo/features/theme/domain/usecases/get_theme_mode.dart';
import 'package:uptodo/features/theme/domain/usecases/set_theme_mode.dart';
import 'package:uptodo/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:uptodo/features/todo/data/data_source/todo_remote_data_source.dart';
import 'package:uptodo/features/todo/data/repo_impl/todo_repo_impl.dart';
import 'package:uptodo/features/todo/domain/repository/todo_repo.dart';
import 'package:uptodo/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:uptodo/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:uptodo/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:uptodo/features/user/data/repository/user_repo_impl.dart';
import 'package:uptodo/features/user/domain/repository/user_repo.dart';
import 'package:uptodo/features/user/domain/usecases/get_user_usecase.dart';
import 'package:uptodo/features/user/domain/usecases/update_photo_url.dart';
import 'package:uptodo/features/user/domain/usecases/update_user_usecase.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

/// Initialize the service locator
Future<void> initGetIt() async {
  // Local Storage
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // Router
  final GoRouterProvider goRouterProvider = GoRouterProvider();
  sl.registerLazySingleton<GoRouterProvider>(() => goRouterProvider);

  // Features - Auth
  sl.registerFactory<AuthBloc>(() => AuthBloc(loginUser: sl(), registerUser: sl(), logoutUser: sl())); // Presentation
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl())); // Usecase
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl())); // Usecase
  sl.registerLazySingleton<LogoutUser>(() => LogoutUser(sl())); // Usecase
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl())); // Repository
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl())); // Data source

  // Features - User
  sl.registerFactory<UserBloc>(() => UserBloc(getUser: sl(), updateUser: sl(), updatePhotoUrl: sl())); // Presentation
  sl.registerLazySingleton<GetUser>(() => GetUser(sl())); // Usecase
  sl.registerLazySingleton<UpdateUser>(() => UpdateUser(sl())); // Usecase
  sl.registerLazySingleton<UpdatePhotoUrl>(() => UpdatePhotoUrl(sl())); // Usecase
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(sl())); // Repository
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl()); // Data source

  // Features - Theme
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(getThemeMode: sl(), setThemeMode: sl())); // Presentation
  sl.registerLazySingleton<GetThemeMode>(() => GetThemeMode(sl())); // Usecase
  sl.registerLazySingleton<SetThemeMode>(() => SetThemeMode(sl())); // Usecase
  sl.registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl())); // Repository
  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSourceImpl(sharedPreferences: sl())); // Data source

  // Features - TODO
  sl.registerFactory<TodoBloc>(() => TodoBloc(getTodos: sl(), updateTodo: sl(), createTodo: sl())); // Presentation
  sl.registerLazySingleton<GetTodos>(() => GetTodos(sl())); // Usecase
  sl.registerLazySingleton<UpdateTodo>(() => UpdateTodo(sl())); // Usecase
  sl.registerLazySingleton<CreateTodo>(() => CreateTodo(sl()));
  sl.registerLazySingleton<TodoRepo>(() => TodoRepoImpl(sl())); // Repository
  sl.registerLazySingleton<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl(sl(), sl())); // Data source
}
