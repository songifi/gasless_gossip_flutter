import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nft_card.dart';
import '../widgets/frequent_gossip_avatar.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText('Welcome', type: AppTextType.body),
                      const SizedBox(width: 4),
                      const Text('👋', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AppText('thetimileyin48', type: AppTextType.h4),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFDBE1E7)),
                ),
                child: const Icon(Icons.notifications_none_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AppText('Wallet Balance', type: AppTextType.caption, color: Colors.black54),
          const SizedBox(height: 4),
          AppText('\$4,192.50', type: AppTextType.h2, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDFDF1),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: const Color(0xFFC8F9D4)),
              ),
              child: Center(
                child: AppText('Fund Wallet', type: AppTextType.caption, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          const SizedBox(height: 32),
          AppText('Frequent Gossips', type: AppTextType.smallBold, color: Color(0xFF4D4845)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FrequentGossipAvatar(
                  name: 'Alexis',
                  imagePath: 'assets/img/avatar-01.png',
                  onTap: () => context.go('/send'),
                ),
                SizedBox(width: 20),
                FrequentGossipAvatar(
                  name: 'Ralph',
                  bgColor: Color(0xFFDFF6E5),
                  onTap: () => context.go('/send'),
                ),
                SizedBox(width: 20),
                FrequentGossipAvatar(
                  name: 'Victor',
                  imagePath: 'assets/img/avatar-02.png',
                  onTap: () => context.go('/send'),
                ),
                SizedBox(width: 20),
                FrequentGossipAvatar(
                  name: 'Anna',
                  imagePath: 'assets/img/avatar-01.png',
                  onTap: () => context.go('/send'),
                ),
                SizedBox(width: 20),
                FrequentGossipAvatar(
                  name: 'Jakub',
                  bgColor: Color(0xFFFFA25B),
                  onTap: () => context.go('/send'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Your NFTs', type: AppTextType.captionBold),
                  const SizedBox(height: 2),
                  AppText('24 total', type: AppTextType.small, color: Colors.black54),
                ],
              ),
              GestureDetector(
                onTap: () => context.go('/all-nfts'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDFDF1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFC8F9D4)),
                  ),
                  child: AppText('See all', type: AppTextType.caption, color: AppTheme.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: NftCard(
                  imagePath: 'assets/img/avatar-01.png',
                  name: 'Ganger Gangsta',
                  price: '24.89',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NftCard(
                  imagePath: 'assets/img/avatar-02.png',
                  name: 'Nerdy Freddy Mendy',
                  price: '24.89',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
} 