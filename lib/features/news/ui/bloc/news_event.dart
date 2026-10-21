part of 'news_bloc.dart';

sealed class NewsEvent {}

class NewsSearched extends NewsEvent {
  final String query;
  NewsSearched(this.query);
}