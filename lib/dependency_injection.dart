import "package:cleane_architecture/cors/network/network_info.dart";
import "package:cleane_architecture/features/books/data/datasources/books_local_data_source.dart";
import "package:cleane_architecture/features/books/data/datasources/books_remote_data_source.dart";
import "package:cleane_architecture/features/books/data/repositories/books_repository_impl.dart";
import "package:cleane_architecture/features/books/domain/repositories/books_repository.dart";
import "package:get_it/get_it.dart";
import "package:internet_connection_checker/internet_connection_checker.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //datasources
  getIt.registerLazySingleton<BooksLocalDataSource>(
      () => BooksLocalDataSourceImpl(sharedPreferences: sharedPreferences));
  getIt.registerLazySingleton<BooksRemoteDataSource>(
      () => BooksRemoteDataSourceImpl(client: http.Client()));

  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //repositories

  getIt.registerLazySingleton<BooksRepository>(() => BooksRepositoryImpl(
      localDataSource: getIt<BooksLocalDataSource>(),
      remoteDataSource: getIt<BooksRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>()));
}
