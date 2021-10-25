import 'package:cat_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:cat_app/features/authentication/domain/usecases/get_current_user.dart';
import 'package:cat_app/features/authentication/domain/usecases/get_user.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_in_with_facebook.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_in_with_google.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_out.dart';
import 'package:cat_app/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:cat_app/features/cat_app/data/datasources/datasources.dart';
import 'package:cat_app/features/cat_app/data/repositories/cat_app_repository_impl.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:cat_app/features/cat_app/domain/usecases/usecases.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerLazySingleton(() => CatAppCubit(
        getNewCats: sl(),
        getFavouriteCats: sl(),
        getCatFacts: sl(),
        saveCatsInDb: sl(),
        saveFactsInDb: sl(),
        setFav: sl(),
        deleteFav: sl(),
        updateCatInDB: sl(),
      ));

  sl.registerLazySingleton(() => AuthCubit(
        getCurrentUser: sl(),
        getUser: sl(),
        logOut: sl(),
      ));

  sl.registerLazySingleton(() => LoginCubit(
        logInWithGoogleUseCase: sl(),
        logInWithFacebookUseCase: sl(),
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

  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => LogInWithGoogle(sl()));
  sl.registerLazySingleton(() => LogInWithFacebook(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));

  // Repository
  sl.registerLazySingleton<CatAppRepository>(
    () {
      return CatAppRepositoryImpl(
        localDataSource: sl<CatAppLocalDataSource>(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      );
    },
  );

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CatAppRemoteDataSource>(
    () => CatAppRemoteDataSourceImpl(client: sl()),
  );

  // sl.pushNewScope(init: (_) {

  //   sl.registerLazySingletonAsync<CatAppLocalDataSource>(() async {
  //   final db = CatAppLocalDataSourceImpl();
  //   await db.openDB();
  //   return db;
  // });
  // }, scopeName: 'authorized', dispose: () {
  //   sl<CatAppLocalDataSource>().closeDB();
  // });
  // sl.popScope();
  // sl.pushNewScope(init: (_) {}, scopeName: 'unauthorized',);

  sl.registerSingletonAsync<CatAppLocalDataSource>(() async {
    final db = CatAppLocalDataSourceImpl();
    await db.openDB();
    return db;
  });

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<firebase_auth.FirebaseAuth>(
      () => firebase_auth.FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FacebookLogin>(() => FacebookLogin());
  return sl.allReady();
}
