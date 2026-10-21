import '../entities/news_article_entity.dart';

abstract class NewsRepository {
  Future<List<NewsArticleEntity>> searchNews(String query, {int page = 1});
}