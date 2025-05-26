import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/wallet"),
        ),
        title: AppText('Send Money', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            _buildSendOption(
              icon: 'assets/img/stark.png',
              title: 'Send via chat',
              subtitle: 'Send STRK to your chat list',
              onTap: () {
                context.go('/send/via-chat');
              },
            ),
            const SizedBox(height: 16),
            _buildSendOption(
              icon: null,
              iconWidget: const Icon(Icons.diamond, color: AppTheme.primaryColor, size: 24),
              title: 'Send NFT',
              subtitle: 'Send NFTs via chat',
              onTap: () {
                context.go('/send');
              },
            ),
            const SizedBox(height: 16),
            _buildSendOption(
              icon: 'assets/img/argent.png',
              title: 'Send to Wallet',
              subtitle: 'Send to external wallet',
              onTap: () {
                context.go('/send');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendOption({
    String? icon,
    Widget? iconWidget,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: icon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(icon, fit: BoxFit.contain),
                    )
                  : iconWidget ?? const Icon(Icons.link, color: Colors.black54, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title, type: AppTextType.body, color: Colors.black),
                  const SizedBox(height: 4),
                  AppText(subtitle, type: AppTextType.small, color: const Color(0xFF6B7280)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B7280), size: 16),
          ],
        ),
      ),
    );
  }
} 