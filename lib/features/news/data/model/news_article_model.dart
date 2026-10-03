import '../../domain/entity/news_article_entity.dart';

class NewsArticleModel extends NewsArticleEntity {
  const NewsArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imagePath,
    required super.date,
    required super.author,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['image'] as String,
      date: DateTime.parse(json['date'] as String),
      author: json['author'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': imagePath,
        'date': date.toIso8601String(),
        'author': author,
      };

  NewsArticleEntity toEntity() => this;
}