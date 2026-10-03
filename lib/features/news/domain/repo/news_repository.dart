import '../entity/news_article_entity.dart';

abstract class NewsRepository {
  Future<List<NewsArticleEntity>> getNews();
}