import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: AppText('Profile', type: AppTextType.h5, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          // Profile Section
          Column(
            children: [
              // Profile Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: const Color(0xFFF9FAFB),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name and Username
              AppText('Ayodeji Balogun', type: AppTextType.h4, color: Colors.black),
              const SizedBox(height: 4),
              AppText('@thebigwiz', type: AppTextType.body, color: const Color(0xFF6B7280)),
              const SizedBox(height: 20),
              // Edit Profile Button
              GestureDetector(
                onTap: () {
                  // Handle edit profile action
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit_outlined, color: Colors.black, size: 16),
                      const SizedBox(width: 8),
                      AppText('Edit Profile', type: AppTextType.caption, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Settings Sections
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Settings Section
                AppText('APP SETTINGS', type: AppTextType.small, color: const Color(0xFF6B7280)),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  icon: Icons.flag_outlined,
                  title: 'Country',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/avatar-01.png', // Using available avatar as flag placeholder
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF10B981),
                                child: const Icon(Icons.flag, color: Colors.white, size: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppText('South Africa', type: AppTextType.caption, color: const Color(0xFF6B7280)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B7280), size: 16),
                    ],
                  ),
                  onTap: () {
                    // Handle country selection
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.backup_outlined,
                  title: 'Backup Account',
                  onTap: () {
                    // Handle backup account
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.restore_outlined,
                  title: 'Restore Account',
                  onTap: () {
                    // Handle restore account
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Connect Wallet',
                  onTap: () {
                    // Handle connect wallet
                  },
                ),
                const SizedBox(height: 32),
                // About Section
                AppText('ABOUT TANDO', type: AppTextType.small, color: const Color(0xFF6B7280)),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'Get Help',
                  onTap: () {
                    // Handle get help
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.quiz_outlined,
                  title: 'FAQs',
                  onTap: () {
                    // Handle FAQs
                  },
                ),
                const SizedBox(height: 32), // Add bottom padding
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF9FAFB),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF10B981), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppText(title, type: AppTextType.caption, color: Colors.black),
            ),
            trailing ?? const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B7280), size: 16),
          ],
        ),
      ),
    );
  }
} 