import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../bloc/news_bloc.dart';
import 'news_details_page.dart';
import 'widgets/article_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>()..add(NewsLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const _SearchField(),
                  const SizedBox(height: 40),
                  const Text(
                    'Latest news',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) => switch (state) {
                        NewsInitial() || NewsLoading() =>
                          const Center(child: CircularProgressIndicator()),
                        NewsFailure(:final message) =>
                          Center(child: Text('Ошибка: $message')),
                        NewsSuccess(:final articles) => GridView.builder(
                            padding: const EdgeInsets.only(bottom: 24),
                            itemCount: articles.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.52,
                            ),
                            itemBuilder: (context, i) => ArticleTile(
                              article: articles[i],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      NewsDetailsPage(article: articles[i]),
                                ),
                              ),
                            ),
                          ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search here...',
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        suffixIcon: const Icon(Icons.search, size: 20),
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}