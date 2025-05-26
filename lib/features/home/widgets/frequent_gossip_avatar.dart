import 'package:flutter/material.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class FrequentGossipAvatar extends StatelessWidget {
  final String name;
  final String? imagePath;
  final Color? bgColor;
  final VoidCallback? onTap;

  const FrequentGossipAvatar({
    super.key,
    required this.name,
    this.imagePath,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: bgColor ?? const Color(0xFFF7F8F9),
            backgroundImage: imagePath != null ? AssetImage(imagePath!) : null,
            child: imagePath == null
                ? AppText(
                    name[0],
                    type: AppTextType.h4,
                    color: AppTheme.primaryColor,
                  )
                : null,
          ),
          const SizedBox(height: 8),
          AppText(
            name,
            type: AppTextType.small,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
} 