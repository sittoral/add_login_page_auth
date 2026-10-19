import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';
import '../models/article_model.dart';

class NewsRemoteDataSource {
  static const _baseUrl = 'https://newsapi.org/v2/everything';

  final http.Client _client;
  NewsRemoteDataSource(this._client);

  Future<List<ArticleModel>> searchNews(String query) async {
    final from = DateTime.now().subtract(const Duration(days: 14));
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'q': query,
      'from': from.toIso8601String().substring(0, 10),
      'sortBy': 'publishedAt',
      'pageSize': '30',
      'apiKey': ApiConfig.newsApiKey,
    });

    final response = await _client.get(uri);
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw Exception(body['message'] ?? 'Ошибка ${response.statusCode}');
    }

    final list = (body['articles'] as List).cast<Map<String, dynamic>>();
    return list
        .map(ArticleModel.fromJson)
        .where((a) => a.title.isNotEmpty && a.title != '[Removed]')
        .toList();
  }
}
