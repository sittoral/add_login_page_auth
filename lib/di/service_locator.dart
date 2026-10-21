import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../data/datasources/news_remote_data_source.dart';
import '../data/repositories/news_repository_impl.dart';
import '../domain/repositories/news_repository.dart';
import '../domain/usecases/search_news_usecase.dart';
import '../presentation/bloc/news_bloc.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // Network
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSource(sl()));
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));

  // Domain
  sl.registerLazySingleton<SearchNewsUseCase>(() => SearchNewsUseCase(sl()));

  // Presentation
  sl.registerFactory<NewsBloc>(() => NewsBloc(sl()));
}
