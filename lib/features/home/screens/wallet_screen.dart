import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class WalletScreenContent extends StatefulWidget {
  const WalletScreenContent({super.key});

  @override
  State<WalletScreenContent> createState() => _WalletScreenContentState();
}

class _WalletScreenContentState extends State<WalletScreenContent> {
  bool isUSDView = false;

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            //const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Select Currency', type: AppTextType.h5, color: Colors.black),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _buildCurrencyOption(
              icon: 'assets/img/stark.png',
              title: 'STRK',
              subtitle: 'Starknet Token',
              isSelected: !isUSDView,
              onTap: () {
                setState(() => isUSDView = false);
                Navigator.pop(context);
              },
            ),
            _buildCurrencyOption(
              icon: 'assets/img/usd.png',
              title: 'USD',
              subtitle: 'US Dollar',
              isSelected: isUSDView,
              onTap: () {
                setState(() => isUSDView = true);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption({
    required String icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(icon, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title, type: AppTextType.body, color: Colors.black),
                  const SizedBox(height: 2),
                  AppText(subtitle, type: AppTextType.small, color: const Color(0xFF6B7280)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 24)
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showWalletAddress() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText('Your Wallet Address', type: AppTextType.small, color: const Color(0xFF6B7280)),
                        AppText('0x0Bbed4Daf99d43D4aBa58fa6e', type: AppTextType.captionBold, color: Colors.black),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.copy, color: AppTheme.primaryColor, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showQRCode();
                },
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.qr_code, color: Colors.black, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppText('View your wallet address', type: AppTextType.body, color: Colors.black),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B7280), size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQRCode() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Wallet Address', type: AppTextType.h5, color: Colors.black),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    AppText('TAP TO COPY', type: AppTextType.small, color: const Color(0xFF6B7280)),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.qr_code, size: 150, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppText(
                '0x0B bed4 Daf9 9d43 D4aB a58f a6eD 5A75 50f6 5553 27',
                type: AppTextType.small,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar content
        Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40), // Spacer to balance the notification icon
                  Expanded(
                    child: Center(
                      child: AppText('Wallet', type: AppTextType.h5, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.black, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Body content
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Currency Selector
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: GestureDetector(
                    onTap: _showCurrencySelector,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(
                              isUSDView ? 'assets/img/usd.png' : 'assets/img/stark.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppText(isUSDView ? 'USD' : 'STRK', type: AppTextType.caption, color: Colors.black),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Balance Section
                AppText('Wallet balance', type: AppTextType.caption, color: const Color(0xFF6B7280)),
                const SizedBox(height: 8),
                if (isUSDView) ...[
                  AppText('\$ 689.00', type: AppTextType.h3, color: Colors.black),
                  const SizedBox(height: 4),
                  AppText('24,9876 STRK', type: AppTextType.caption, color: const Color(0xFF6B7280)),
                ] else ...[
                  AppText('24,9087 STRK', type: AppTextType.h3, color: Colors.black),
                  const SizedBox(height: 4),
                  AppText('\$ 689.00', type: AppTextType.caption, color: const Color(0xFF6B7280)),
                ],
                const SizedBox(height: 30),
                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.north_east,
                        label: 'Send',
                        onTap: () => context.go('/send-money'),
                      ),
                      _buildActionButton(
                        icon: Icons.add,
                        label: 'Fund',
                        isPrimary: true,
                        onTap: () => context.go('/fund'),
                      ),
                      _buildActionButton(
                        icon: Icons.account_balance,
                        label: 'Details',
                        onTap: _showWalletAddress,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Recent Transactions
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText('Recent Transaction', type: AppTextType.captionBold, color: Colors.black),
                            Row(
                              children: [
                                AppText('See all', type: AppTextType.captionBold, color: AppTheme.primaryColor),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, color: AppTheme.primaryColor, size: 16),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _buildTransactionItem(
                                icon: Icons.south_west,
                                iconColor: AppTheme.primaryColor,
                                iconBg: AppTheme.primaryColor.withOpacity(0.1),
                                title: 'Xaxxo just sent you STRK',
                                date: '15 March, 2025 • 12:43 PM',
                                amount: '+400 USD',
                                amountColor: AppTheme.primaryColor,
                                strk: '10,654 STRK',
                              ),
                              _buildTransactionItem(
                                icon: Icons.north_east,
                                iconColor: Colors.black,
                                iconBg: const Color(0xFFF9FAFB),
                                title: 'Bet placed',
                                date: '15 March, 2025 • 12:43 PM',
                                amount: '-400 USD',
                                amountColor: Colors.black,
                                strk: '10,654 STRK',
                              ),
                              _buildTransactionItem(
                                icon: Icons.add,
                                iconColor: AppTheme.primaryColor,
                                iconBg: AppTheme.primaryColor.withOpacity(0.1),
                                title: 'Wallet Funded',
                                date: '15 March, 2025 • 12:43 PM',
                                amount: '+400 USD',
                                amountColor: AppTheme.primaryColor,
                                strk: '10,654 STRK',
                              ),
                              _buildTransactionItem(
                                icon: Icons.diamond,
                                iconColor: AppTheme.primaryColor,
                                iconBg: AppTheme.primaryColor.withOpacity(0.1),
                                title: 'Xaxxo just sent you a NFT',
                                date: '15 March, 2025 • 12:43 PM',
                                amount: '+400 USD',
                                amountColor: AppTheme.primaryColor,
                                strk: '10,654 STRK',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: isPrimary ? AppTheme.primaryColor : const Color(0xFFF9FAFB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          AppText(label, type: AppTextType.small, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
    required String strk,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title, type: AppTextType.captionBold, color: Colors.black),
                const SizedBox(height: 4),
                AppText(date, type: AppTextType.small, color: const Color(0xFF6B7280)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(amount, type: AppTextType.captionBold, color: amountColor),
              const SizedBox(height: 4),
              AppText(strk, type: AppTextType.small, color: const Color(0xFF6B7280)),
            ],
          ),
        ],
      ),
    );
  }
} 