part of 'news_bloc.dart';

sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<NewsArticleEntity> articles;
  NewsSuccess(this.articles);
}

class NewsFailure extends NewsState {
  final String message;
  NewsFailure(this.message);
}