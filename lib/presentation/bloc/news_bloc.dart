import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/usecases/search_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final SearchNewsUseCase _searchNews;

  NewsBloc(this._searchNews) : super(NewsInitial()) {
    on<NewsSearched>(_onSearched);
  }

  Future<void> _onSearched(NewsSearched event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final articles = await _searchNews(event.query);
      emit(NewsSuccess(articles, event.query));
    } catch (e) {
      emit(NewsFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}