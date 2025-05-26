import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  final List<Map<String, dynamic>> chats = [
    {
      'avatar': 'assets/img/avatar-01.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'delivered',
      'unread': 0,
    },
    {
      'avatar': 'assets/img/avatar-02.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'read',
      'unread': 0,
    },
    {
      'avatar': 'assets/img/avatar-01.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'sent',
      'unread': 0,
    },
    {
      'avatar': 'assets/img/avatar-02.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'read',
      'unread': 4,
    },
    {
      'avatar': 'assets/img/avatar-01.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'delivered',
      'unread': 0,
    },
    {
      'avatar': 'assets/img/avatar-02.png',
      'name': 'thetimileyin',
      'last': 'Attachment: 2 NFTs',
      'time': '22:17',
      'status': 'read',
      'unread': 0,
      'nft': true,
    },
    {
      'avatar': 'assets/img/avatar-01.png',
      'name': 'thetimileyin',
      'last': 'Attachment: STRK',
      'time': '22:17',
      'status': 'read',
      'unread': 0,
      'strk': true,
    },
    {
      'avatar': 'assets/img/avatar-02.png',
      'name': 'thetimileyin',
      'last': 'GM serrrr',
      'time': '22:17',
      'status': 'read',
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredChats = chats
        .where((c) => c['name'].toLowerCase().contains(_search.toLowerCase()))
        .toList();
    
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: AppText('Chats', type: AppTextType.h4, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: AppInput(
            controller: _searchController,
            hintText: 'Search...',
            borderColor: const Color(0xFFDBE1E7),
            fillColor: const Color(0xFFF7F8F9),
            onChanged: (val) => setState(() => _search = val),
            prefixIcon: Icon(Icons.search, color: Colors.black38),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: filteredChats.length,
            separatorBuilder: (_, __) => const SizedBox(height: 0),
            itemBuilder: (context, i) {
              final chat = filteredChats[i];
              return ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFF7F8F9),
                  backgroundImage: AssetImage(chat['avatar']),
                ),
                title: AppText(chat['name'], type: AppTextType.captionBold),
                subtitle: chat['nft'] == true
                    ? AppText(
                        chat['last'],
                        type: AppTextType.small,
                        color: Colors.black54,
                      )
                    : chat['strk'] == true
                        ? AppText(
                            chat['last'],
                            type: AppTextType.small,
                            color: AppTheme.primaryColor,
                          )
                        : AppText(
                            chat['last'],
                            type: AppTextType.small,
                            color: Colors.black54,
                          ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      chat['time'],
                      type: AppTextType.small,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 4),
                    if (chat['unread'] > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AppText(
                          '${chat['unread']}',
                          type: AppTextType.small,
                          color: Colors.white,
                        ),
                      )
                    else if (chat['status'] == 'read')
                      const Icon(
                        Icons.done_all,
                        size: 18,
                        color: Colors.black38,
                      )
                    else if (chat['status'] == 'delivered')
                      const Icon(Icons.done, size: 18, color: Colors.black38)
                    else if (chat['status'] == 'sent')
                      const Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.black26,
                      ),
                  ],
                ),
                onTap: () {
                  context.go('/chat-detail');
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                minVerticalPadding: 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
