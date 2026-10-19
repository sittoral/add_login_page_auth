import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

class SearchNewsUseCase {
  final NewsRepository _repository;
  SearchNewsUseCase(this._repository);

  Future<List<NewsArticleEntity>> call(String query) =>
      _repository.searchNews(query);
}