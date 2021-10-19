import 'package:cat_app/features/cat_app/data/datasources/datasources.dart';
import 'package:cat_app/features/cat_app/data/repositories/cat_app_repository_impl.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:cat_app/features/cat_app/domain/usecases/usecases.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => CatAppCubit(
        getNewCats: sl(),
        getFavouriteCats: sl(),
        getCatFacts: sl(),
        saveCatsInDb: sl(),
        saveFactsInDb: sl(),
        setFav: sl(),
        deleteFav: sl(),
        updateCatInDB: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetNewCats(sl()));
  sl.registerLazySingleton(() => GetFavouriteCats(sl()));
  sl.registerLazySingleton(() => GetCatFacts(sl()));
  sl.registerLazySingleton(() => SaveCatsInDb(sl()));
  sl.registerLazySingleton(() => SaveFactsInDb(sl()));
  sl.registerLazySingleton(() => SetFav(sl()));
  sl.registerLazySingleton(() => DeleteFav(sl()));
  sl.registerLazySingleton(() => UpdateCatInDB(sl()));

  // Repository
  sl.registerLazySingleton<CatAppRepository>(
    () => CatAppRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CatAppRemoteDataSource>(
    () => CatAppRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CatAppLocalDataSource>(
      () => CatAppLocalDataSourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  sl.registerLazySingleton(() => http.Client());
}
