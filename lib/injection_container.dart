import 'package:get_it/get_it.dart';
import 'package:uptodo/config/routes/router.dart';

final getIt = GetIt.instance;

/// Initialize the service locator
void initGetIt() {
  getIt.registerSingleton<GoRouterProvider>(GoRouterProvider());
  // Repositories
  // Interactions
  // Stores
}

// globalBloc
// { Inherited Wrapper }
