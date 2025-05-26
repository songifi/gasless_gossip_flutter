import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';

class FundStrkWalletScreen extends StatelessWidget {
  const FundStrkWalletScreen({super.key});

  final String walletAddress = '0x0B bed4 Daf9 9d43 D4aB a58f a6eD 5A75 50f6 5553 27';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/fund"),
        ),
        title: AppText('From STRK Wallet', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Below is your wallet address. Copy or share to receive STRK into your Gasless Gossip wallet.',
              type: AppTextType.caption,
              color: const Color(0xFF6B7280),
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: [
                      AppText(
                        'TAP TO COPY',
                        type: AppTextType.small,
                        color: const Color(0xFF6B7280),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.qr_code, size: 150, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset('assets/img/stark.png', fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(width: 8),
                          AppText('Starknet', type: AppTextType.caption, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: AppText(
                walletAddress,
                type: AppTextType.small,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: walletAddress.replaceAll(' ', '')));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText('Wallet address copied to clipboard', type: AppTextType.caption, color: Colors.white),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
} 