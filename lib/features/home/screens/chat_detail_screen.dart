import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
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
              const SizedBox(height: 24),
              _buildAttachmentOption(
                icon: Icons.currency_exchange,
                iconColor: const Color(0xFF3B82F6),
                iconBg: const Color(0xFFEFF6FF),
                title: 'STRK',
                subtitle: 'Send STRK to your friend',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to send STRK
                },
              ),
              _buildAttachmentOption(
                icon: Icons.diamond,
                iconColor: const Color(0xFF10B981),
                iconBg: const Color(0xFFECFDF5),
                title: 'NFTs',
                subtitle: 'Send an NFT to your friend',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to send NFT
                },
              ),
              _buildAttachmentOption(
                icon: Icons.camera_alt,
                iconColor: const Color(0xFF6B7280),
                iconBg: const Color(0xFFF9FAFB),
                title: 'Camera',
                subtitle: '',
                onTap: () {
                  Navigator.pop(context);
                  // Open camera
                },
              ),
              _buildAttachmentOption(
                icon: Icons.photo_library,
                iconColor: const Color(0xFF6B7280),
                iconBg: const Color(0xFFF9FAFB),
                title: 'Photos',
                subtitle: '',
                onTap: () {
                  Navigator.pop(context);
                  // Open photo gallery
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title, type: AppTextType.body, color: Colors.black),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    AppText(subtitle, type: AppTextType.small, color: const Color(0xFF6B7280)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = [
      {
        'fromMe': true,
        'text': 'GM to those that Gm.\nHow you doing man? I wanna send you some STRK but you gotta sing for me first😶‍🌫️',
        'time': '16:40',
        'status': 'read',
        'date': 'Today 16:23',
      },
      {
        'fromMe': false,
        'text': 'Man in as much as you are sending me that STRK, I can twerk if you want me to. Hell I will do whatever you want😜😘',
        'time': '',
        'status': 'delivered',
      },
      {
        'fromMe': true,
        'text': 'GM to those that Gm.\nHow you doing man? I wanna send you some STRK but you gotta sing for me first😶‍🌫️',
        'time': '16:40',
        'status': 'read',
      },
      {
        'fromMe': false,
        'text': 'Man in as much as you are sending me that STRK, I can twerk if you want me to. Hell I will do whatever you want😜😘',
        'time': '',
        'status': 'delivered',
      },
      {
        'fromMe': false,
        'text': 'Hey you there?? I was kidding',
        'time': '',
        'status': 'delivered',
      },
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          color: const Color(0xFFF7F8F9),
          child: SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                  onPressed: () => context.go("/chats"),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFE7F1EA),
                        backgroundImage: const AssetImage('assets/img/avatar-02.png'),
                      ),
                      const SizedBox(height: 8),
                      AppText('theXaxxo Outlook', type: AppTextType.small, color: Colors.black54),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          AppText('Today 16:23', type: AppTextType.small, color: Colors.black38),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];
                final isMe = msg['fromMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFEDFDF1) : const Color(0xFFF7F8F9),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                    ),
                    child: AppText(
                      msg['text'] as String,
                      type: AppTextType.caption,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F8F9),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: _showAttachmentOptions,
                      child: Icon(Icons.add, color: AppTheme.primaryColor, size: 24),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Nigga leave me alone',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 18,
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
      ),
    );
  }
} 