import 'package:injectable/injectable.dart';
import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

@lazySingleton
class SearchNewsUseCase {
  final NewsRepository _repository;
  SearchNewsUseCase(this._repository);

  Future<List<NewsArticleEntity>> call(String query, {int page = 1}) =>
      _repository.searchNews(query, page: page);
}