import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entity/news_article_entity.dart';

class NewsDetailsPage extends StatefulWidget {
  final NewsArticleEntity article;
  const NewsDetailsPage({super.key, required this.article});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final a = widget.article;
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                    child: Column(
                      children: [
                        Container(
                          height: 260,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(a.imagePath, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          a.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          a.author,
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _Info(label: 'Автор', value: a.author),
                            _Info(
                                label: 'Дата',
                                value: DateFormat('d MMM').format(a.date)),
                            _Info(
                                label: 'Год',
                                value: DateFormat('yyyy').format(a.date)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Описание',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey.shade500)),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => setState(() => _expanded = !_expanded),
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(text: a.description),
                              TextSpan(
                                text: _expanded ? '  СКРЫТЬ' : '  ЕЩЁ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 11),
                              ),
                            ]),
                            maxLines: _expanded ? null : 5,
                            overflow: _expanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.grey.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
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

class _Info extends StatelessWidget {
  final String label;
  final String value;
  const _Info({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }
}