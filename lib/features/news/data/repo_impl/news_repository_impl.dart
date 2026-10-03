import '../../domain/entity/news_article_entity.dart';
import '../../domain/repo/news_repository.dart';
import '../remote/api/news_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource _dataSource;
  NewsRepositoryImpl(this._dataSource);

  @override
  Future<List<NewsArticleEntity>> getNews() async {
    final models = await _dataSource.getNews();
    return models.map((m) => m.toEntity()).toList();
  }
}