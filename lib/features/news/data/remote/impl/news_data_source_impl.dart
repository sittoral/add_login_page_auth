import '../../model/news_article_model.dart';
import '../api/news_data_source.dart';

/// Mock-источник. Позже заменишь на Dio/http, интерфейс останется тем же.
class NewsDataSourceImpl implements NewsDataSource {
  static const _long =
      'Это подробное описание новости. Здесь может быть длинный текст статьи: '
      'предыстория события, комментарии экспертов, цитаты участников и '
      'прогнозы на будущее. Текст специально сделан длинным, чтобы на экране '
      'деталей работала кнопка «Ещё» и было видно, как раскрывается описание. '
      'Дополнительный абзац нужен, чтобы проверить перенос строк и отступы.';

  static final List<Map<String, dynamic>> _json = [
    {
      'id': 1,
      'title': 'Запуск новой космической миссии',
      'description': _long,
      'image': 'assets/images/cover1.png',
      'date': '2026-10-01T10:00:00',
      'author': 'Анна Петрова',
    },
    {
      'id': 2,
      'title': 'Технологии будущего уже рядом',
      'description': _long,
      'image': 'assets/images/cover2.png',
      'date': '2026-09-28T09:30:00',
      'author': 'Иван Сидоров',
    },
    {
      'id': 3,
      'title': 'Итоги экономического форума',
      'description': _long,
      'image': 'assets/images/cover3.png',
      'date': '2026-09-25T14:15:00',
      'author': 'Мария Орлова',
    },
    {
      'id': 4,
      'title': 'Спортивные новости недели',
      'description': _long,
      'image': 'assets/images/cover4.png',
      'date': '2026-09-20T18:45:00',
      'author': 'Олег Смирнов',
    },
  ];

  @override
  Future<List<NewsArticleModel>> getNews() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _json.map(NewsArticleModel.fromJson).toList();
  }
}