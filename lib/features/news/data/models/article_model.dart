import '../../domain/entities/news_article_entity.dart';

class ArticleModel extends NewsArticleEntity {
  const ArticleModel({
    required super.title,
    required super.description,
    required super.content,
    required super.imageUrl,
    required super.publishedAt,
    required super.author,
    required super.sourceName,
    required super.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final sourceName =
        (json['source'] as Map<String, dynamic>?)?['name'] as String? ??
            'Unknown';
    final rawAuthor = (json['author'] as String?)?.trim();

    return ArticleModel(
      title: (json['title'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim() ?? '',
      content: _cleanContent(json['content'] as String?),
      imageUrl: json['urlToImage'] as String?,
      publishedAt:
          DateTime.tryParse(json['publishedAt'] as String? ?? '')?.toLocal() ??
              DateTime.now(),
      author: (rawAuthor == null || rawAuthor.isEmpty) ? sourceName : rawAuthor,
      sourceName: sourceName,
      url: json['url'] as String? ?? '',
    );
  }

  /// Убирает хвост вида "[+152 chars]" из content.
  static String _cleanContent(String? raw) =>
      (raw ?? '').replaceAll(RegExp(r'\s*\[\+\d+ chars\]'), '').trim();
}