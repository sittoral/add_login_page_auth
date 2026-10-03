import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/news_article_entity.dart';
import '../../domain/usecase/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNews;

  NewsBloc(this._getNews) : super(NewsInitial()) {
    on<NewsLoaded>(_onLoaded);
  }

  Future<void> _onLoaded(NewsLoaded event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      emit(NewsSuccess(await _getNews()));
    } catch (e) {
      emit(NewsFailure(e.toString()));
    }
  }
}