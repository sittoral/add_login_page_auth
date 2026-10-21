import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/service/prefs_service.dart';
import '../../../../core/service/secure_storage_service.dart';
import '../../../news/ui/pages/main_page.dart';
import 'login_page.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    bool onboardingSeen = false;
    bool authorized = false;

    try {
      onboardingSeen = await PrefsService().isOnboardingSeen();
    } catch (_) {}

    try {
      final token = await sl<SecureStorageService>().read('accessToken');
      authorized = token != null && token.isNotEmpty;
    } catch (_) {}

    if (!mounted) return;

    final Widget page;
    if (!onboardingSeen) {
      page = const OnboardingPage();
    } else if (authorized) {
      page = const MainPage();
    } else {
      page = const LoginPage();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white);
  }
}