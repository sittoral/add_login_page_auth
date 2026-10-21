import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 28),
                const _PrefRow(title: 'ACCOUNT'),
                const _PrefRow(title: 'SETTINGS'),
                const _PrefRow(title: 'ORDERS PREFERENCES'),
                _PrefRow(
                  title: 'LOGOUT',
                  showArrow: false,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout')),
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

class _PrefRow extends StatelessWidget {
  final String title;
  final bool showArrow;
  final VoidCallback? onTap;

  const _PrefRow({
    required this.title,
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 0.8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            if (showArrow)
              Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
