import 'package:equatable/equatable.dart';

class NewsArticleEntity extends Equatable {
  final String title;
  final String description;
  final String content;
  final String? imageUrl;
  final DateTime publishedAt;
  final String author;
  final String sourceName;
  final String url;

  const NewsArticleEntity({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.publishedAt,
    required this.author,
    required this.sourceName,
    required this.url,
  });

  @override
  List<Object?> get props => [url, title, publishedAt];
}