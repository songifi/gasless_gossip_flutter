import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class NftCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback? onTap;

  const NftCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8F9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDBE1E7)),
        ),
        child: Stack(
          children: [
            // NFT image as background
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Price chip
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDFDF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  '\$ $price',
                  type: AppTextType.small,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            // Name at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: AppText(
                  name,
                  type: AppTextType.small,
                  color: Colors.black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 