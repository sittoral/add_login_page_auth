import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../widgets/article_tile.dart';
import 'news_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController(text: 'tesla');

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(NewsSearched(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    FocusScope.of(context).unfocus();
    context.read<NewsBloc>().add(NewsSearched(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _search(),
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    hintStyle:
                        TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, size: 20),
                      onPressed: _search,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F1F1),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
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
                      NewsFailure(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Ошибка: $message',
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 12),
                              OutlinedButton(
                                onPressed: _search,
                                child: const Text('Повторить'),
                              ),
                            ],
                          ),
                        ),
                      NewsSuccess(:final articles, :final query) =>
                        articles.isEmpty
                            ? Center(
                                child: Text('Ничего не найдено по «$query»'))
                            : GridView.builder(
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
                                      builder: (_) => NewsDetailsPage(
                                          article: articles[i]),
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
    );
  }
}