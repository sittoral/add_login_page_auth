import 'package:get_it/get_it.dart';
import '../../features/news/data/remote/api/news_data_source.dart';
import '../../features/news/data/remote/impl/news_data_source_impl.dart';
import '../../features/news/data/repo_impl/news_repository_impl.dart';
import '../../features/news/domain/repo/news_repository.dart';
import '../../features/news/domain/usecase/get_news_usecase.dart';
import '../../features/news/ui/bloc/news_bloc.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton<NewsDataSource>(() => NewsDataSourceImpl());
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetNewsUseCase(sl()));
  sl.registerFactory(() => NewsBloc(sl()));
}