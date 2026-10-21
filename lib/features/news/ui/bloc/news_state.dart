part of 'news_bloc.dart';

sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<NewsArticleEntity> articles;
  final String query;
  final bool hasReachedMax;
  final bool isLoadingMore;

  NewsSuccess(
    this.articles,
    this.query, {
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  NewsSuccess copyWith({
    List<NewsArticleEntity>? articles,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) =>
      NewsSuccess(
        articles ?? this.articles,
        query,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );
}

class NewsFailure extends NewsState {
  final String message;
  NewsFailure(this.message);
}