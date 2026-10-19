import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/news_remote_data_source.dart';
import 'data/repositories/news_repository_impl.dart';
import 'domain/usecases/search_news_usecase.dart';
import 'presentation/bloc/news_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  // Ручной DI: собираем зависимости снизу вверх
  final dataSource = NewsRemoteDataSource(http.Client());
  final repository = NewsRepositoryImpl(dataSource);
  final searchNews = SearchNewsUseCase(repository);

  runApp(MyApp(searchNews: searchNews));
}

class MyApp extends StatelessWidget {
  final SearchNewsUseCase searchNews;
  const MyApp({super.key, required this.searchNews});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(searchNews),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorSchemeSeed: Colors.deepPurple,
        ),
        home: const HomePage(),
      ),
    );
  }
}