import 'package:equatable/equatable.dart';

class NewsArticleEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final String author;

  const NewsArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.author,
  });

  @override
  List<Object?> get props => [id, title, description, imagePath, date, author];
}