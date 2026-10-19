part of 'news_bloc.dart';

sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<NewsArticleEntity> articles;
  final String query;
  NewsSuccess(this.articles, this.query);
}

class NewsFailure extends NewsState {
  final String message;
  NewsFailure(this.message);
}
