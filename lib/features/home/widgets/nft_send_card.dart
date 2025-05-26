import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class NftSendCard extends StatelessWidget {
  final String imagePath;
  final String price;
  final VoidCallback? onTap;

  const NftSendCard({
    super.key,
    required this.imagePath,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF7F8F9),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDFDF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  '\$ ${price}',
                  type: AppTextType.small,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 