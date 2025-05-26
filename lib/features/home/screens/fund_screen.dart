import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class FundScreen extends StatelessWidget {
  const FundScreen({super.key});

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
        title: AppText('Fund Wallet', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            _buildFundOption(
              icon: 'assets/img/apple-icon.png',
              title: 'Buy Crypto',
              subtitle: 'Apple Pay, card or bank transfer',
              onTap: () {
                // Navigate to buy crypto screen
              },
            ),
            const SizedBox(height: 16),
            _buildFundOption(
              icon: 'assets/img/stark.png',
              title: 'From STRK Wallet',
              subtitle: 'Argent, Binance, e.t.c',
              onTap: () {
                context.go('/fund/strk-wallet');
              },
            ),
            const SizedBox(height: 16),
            _buildFundOption(
              icon: null,
              title: 'From Other Chains',
              subtitle: 'Argent, Binance, e.t.c',
              onTap: () {
                context.go('/fund/other-chains');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFundOption({
    String? icon,
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
                  : const Icon(Icons.link, color: Colors.black54, size: 24),
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