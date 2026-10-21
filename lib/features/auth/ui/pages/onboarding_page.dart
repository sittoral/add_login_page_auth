import 'package:flutter/material.dart';
import '../../../../core/service/prefs_service.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  static const _pages = [
    _OnboardingData(
      icon: Icons.newspaper,
      title: 'Свежие новости',
      description:
          'Читай последние новости со всего мира: фото, заголовок, описание и автор в одной ленте.',
    ),
    _OnboardingData(
      icon: Icons.search,
      title: 'Умный поиск',
      description:
          'Введи любую тему, например tesla или football, и сразу получи подборку статей.',
    ),
    _OnboardingData(
      icon: Icons.menu_book_outlined,
      title: 'Подробности',
      description:
          'Открывай любую новость и читай полное описание, источник и дату публикации.',
    ),
  ];

  bool get _isLast => _index == _pages.length - 1;

  Future<void> _finish() async {
    try {
      await PrefsService().setOnboardingSeen();
    } catch (_) {}
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _next() {
    if (_isLast) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _finish,
                      child: const Text(
                        'Пропустить',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageChanged: (i) => setState(() => _index = i),
                      itemBuilder: (_, i) => _OnboardingSlide(data: _pages[i]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < _pages.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == _index
                                ? Colors.black
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: _next,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isLast ? 'Начать' : 'Далее',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
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

class _OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _OnboardingSlide extends StatelessWidget {
  final _OnboardingData data;
  const _OnboardingSlide({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F1F1),
            shape: BoxShape.circle,
          ),
          child: Icon(data.icon, size: 72),
        ),
        const SizedBox(height: 40),
        Text(
          data.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}