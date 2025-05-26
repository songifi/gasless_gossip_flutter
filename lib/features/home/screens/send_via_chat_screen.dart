import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';

class SendViaChatScreen extends StatefulWidget {
  const SendViaChatScreen({super.key});

  @override
  State<SendViaChatScreen> createState() => _SendViaChatScreenState();
}

class _SendViaChatScreenState extends State<SendViaChatScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _frequentGossips = [
    {
      'name': 'Alexis',
      'avatar': 'assets/img/avatar-01.png',
    },
    {
      'name': 'Ralph',
      'avatar': null,
      'color': const Color(0xFF00D4AA),
      'initial': 'R',
    },
    {
      'name': 'Victor',
      'avatar': 'assets/img/avatar-02.png',
    },
    {
      'name': 'Anna',
      'avatar': 'assets/img/avatar-01.png',
    },
    {
      'name': 'Jakub',
      'avatar': null,
      'color': const Color(0xFFFF6B35),
      'initial': 'J',
    },
  ];

  final List<Map<String, dynamic>> _allContacts = [
    {
      'name': 'thetimileyin',
      'subtitle': 'GM serrrr',
      'avatar': 'assets/img/avatar-01.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'GM serrrr',
      'avatar': 'assets/img/avatar-02.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'GM serrrr',
      'avatar': 'assets/img/avatar-01.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'GM serrrr',
      'avatar': 'assets/img/avatar-02.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'GM serrrr',
      'avatar': 'assets/img/avatar-01.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'Attachment: 2 NFTs',
      'avatar': 'assets/img/avatar-02.png',
    },
    {
      'name': 'thetimileyin',
      'subtitle': 'Attachment: STRK',
      'avatar': 'assets/img/avatar-02.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/send-money"),
        ),
        title: AppText('Send via Chat', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chat_outlined, color: AppTheme.primaryColor, size: 20),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Color(0xFF6B7280)),
                  focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF6B7280)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppText('Frequent Gossips', type: AppTextType.captionBold, color: const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _frequentGossips.length,
              itemBuilder: (context, index) {
                final gossip = _frequentGossips[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to send screen with selected contact
                      context.go('/send');
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: gossip['color'] ?? Colors.white,
                            shape: BoxShape.circle,
                            image: gossip['avatar'] != null
                                ? DecorationImage(
                                    image: AssetImage(gossip['avatar']),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: gossip['avatar'] == null
                              ? Center(
                                  child: AppText(
                                    gossip['initial'] ?? gossip['name'][0].toUpperCase(),
                                    type: AppTextType.h5,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        AppText(gossip['name'], type: AppTextType.small, color: Colors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppText('All Contacts', type: AppTextType.captionBold, color: const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _allContacts.length,
              itemBuilder: (context, index) {
                final contact = _allContacts[index];
                return _buildContactItem(
                  name: contact['name'],
                  subtitle: contact['subtitle'],
                  avatar: contact['avatar'],
                  onTap: () {
                    // Navigate to send screen with selected contact
                    context.go('/send');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required String name,
    required String subtitle,
    required String avatar,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(avatar),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(name, type: AppTextType.body, color: Colors.black),
                  const SizedBox(height: 4),
                  AppText(subtitle, type: AppTextType.small, color: const Color(0xFF6B7280)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
} 