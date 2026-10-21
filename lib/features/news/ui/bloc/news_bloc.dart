import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/usecases/search_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final SearchNewsUseCase _searchNews;
  int _page = 1;

  NewsBloc(this._searchNews) : super(NewsInitial()) {
    on<NewsSearched>(_onSearched);
    on<NewsLoadMore>(_onLoadMore);
  }

  Future<void> _onSearched(NewsSearched event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    _page = 1;
    try {
      final articles = await _searchNews(event.query, page: 1);
      emit(NewsSuccess(
        articles,
        event.query,
        hasReachedMax: articles.isEmpty,
      ));
    } catch (e) {
      emit(NewsFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onLoadMore(NewsLoadMore event, Emitter<NewsState> emit) async {
    final current = state;
    if (current is! NewsSuccess ||
        current.hasReachedMax ||
        current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));
    try {
      final next = await _searchNews(current.query, page: _page + 1);
      _page++;
      emit(current.copyWith(
        articles: [...current.articles, ...next],
        hasReachedMax: next.isEmpty,
        isLoadingMore: false,
      ));
    } catch (_) {
      // лимит NewsAPI или ошибка сети: останавливаем подгрузку, список остаётся
      emit(current.copyWith(hasReachedMax: true, isLoadingMore: false));
    }
  }
}