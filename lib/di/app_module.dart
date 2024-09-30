import 'package:get_it/get_it.dart';
import 'package:house_rent/data/datasource/local/app_database.dart';
import 'package:house_rent/data/datasource/local/preferences.dart';
import 'package:house_rent/data/repository/reading_repository_impl.dart';
import 'package:house_rent/data/repository/tenant_repository_impl.dart';
import 'package:house_rent/domain/repository/reading_repository.dart';
import 'package:house_rent/domain/repository/tenant_repository.dart';
import 'package:house_rent/domain/usecases/reading_use_case.dart';
import 'package:house_rent/domain/usecases/tenant_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> setupGetIt() async {
  //Shared Preferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPrefs>(SharedPrefs(prefs));

  //App Database
  sl.registerSingletonAsync<AppDatabase>(() async {
    final appDb = AppDatabase();
    await appDb.db;
    return appDb;
  });

  // Wait for all async singletons to be ready
  await sl.allReady();

  //Repositories
  sl.registerLazySingleton<TenantRepository>(
    () => TenantRepositoryImpl(
      sl<AppDatabase>(),
    ),
  );

  sl.registerLazySingleton<ReadingRepository>(
    () => ReadingRepositoryImpl(
      sl<AppDatabase>(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<TenantUseCase>(
    () => TenantUseCase(
      sl<TenantRepository>(),
    ),
  );

  sl.registerLazySingleton<ReadingUseCase>(
    () => ReadingUseCase(
      sl<ReadingRepository>(),
    ),
  );
}
