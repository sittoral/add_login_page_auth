import 'package:injectable/injectable.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remote;
  NewsRepositoryImpl(this._remote);

  @override
  Future<List<NewsArticleEntity>> searchNews(String query, {int page = 1}) =>
      _remote.searchNews(query, page: page);
}