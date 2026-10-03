import '../entity/news_article_entity.dart';
import '../repo/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository _repository;
  GetNewsUseCase(this._repository);

  Future<List<NewsArticleEntity>> call() => _repository.getNews();
}