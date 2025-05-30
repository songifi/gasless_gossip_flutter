import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:gasless_gossip/services/chat_transaction_notifier.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<Map<String, dynamic>> messages = [
    {
      'fromMe': false,
      'text': 'Hey! How you doing? I heard you got some STRK 👀',
      'time': '14:32',
      'status': 'delivered',
      'type': 'text',
    },
    {
      'fromMe': true,
      'text': 'GM bro! Yeah I got some, why?',
      'time': '14:35',
      'status': 'read',
      'type': 'text',
    },
    {
      'fromMe': false,
      'text': 'Could you send me some STRK? I need it for a new DeFi project I\'m testing 🚀',
      'time': '14:36',
      'status': 'delivered',
      'type': 'text',
    },
    {
      'fromMe': true,
      'text': 'Sure! How much do you need?',
      'time': '14:38',
      'status': 'read',
      'type': 'text',
    },
    {
      'fromMe': false,
      'text': 'Maybe around 20-30 STRK? That would be perfect! 🙏',
      'time': '14:40',
      'status': 'delivered',
      'type': 'text',
    },
  ];

  final List<String> _autoResponses = [
    "Thanks! Let me know when you send it 🚀",
    "Perfect! Send me some STRK when you can 💫",
    "That sounds good! Could you send some STRK? 💰",
    "Awesome! I'm waiting for that STRK transfer ⚡",
    "Great! Don't forget to send me those tokens 🎯",
  ];

  @override
  void initState() {
    super.initState();
    // Check for any pending transactions when screen loads
    _checkForTransactionResult();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      // Add user message
      messages.add({
        'fromMe': true,
        'text': _controller.text.trim(),
        'time': _getCurrentTime(),
        'status': 'sent',
        'type': 'text',
      });
    });

    final userMessage = _controller.text.trim();
    _controller.clear();

    // Auto-reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          messages.add({
            'fromMe': false,
            'text': _getSmartResponse(userMessage),
            'time': _getCurrentTime(),
            'status': 'delivered',
            'type': 'text',
          });
        });
        _scrollToBottom();
      }
    });

    _scrollToBottom();
  }

  String _getSmartResponse(String userMessage) {
    final msg = userMessage.toLowerCase();
    
    if (msg.contains('send') || msg.contains('strk') || msg.contains('token')) {
      return "Perfect! Send me some STRK through the chat. Just tap + and select STRK 🎯";
    } else if (msg.contains('how much') || msg.contains('amount')) {
      return "Maybe 15-25 STRK? Whatever you can spare! 💰";
    } else if (msg.contains('hi') || msg.contains('hello') || msg.contains('hey')) {
      return "Hey! Could you send me some STRK tokens? I need them for testing 🚀";
    } else if (msg.contains('ok') || msg.contains('sure') || msg.contains('yes')) {
      return "Awesome! You can send STRK right here in the chat. Just use the + button! ⚡";
    } else {
      return _autoResponses[DateTime.now().millisecond % _autoResponses.length];
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addTransactionMessage(String amount, String txHash) {
    setState(() {
      messages.add({
        'fromMe': true,
        'text': 'Sent you $amount STRK! 🎉',
        'time': _getCurrentTime(),
        'status': 'sent',
        'type': 'transaction',
        'amount': amount,
        'txHash': txHash,
      });
    });

    // Auto-reply with thanks
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          messages.add({
            'fromMe': false,
            'text': 'Amazing! I got the $amount STRK! Thank you so much! 🙏✨\n\nYou\'re the best! The transaction went through perfectly 🚀',
            'time': _getCurrentTime(),
            'status': 'delivered',
            'type': 'text',
          });
        });
        _scrollToBottom();
      }
    });

    _scrollToBottom();
  }

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
                  // Navigate to send STRK screen and pass callback
                  context.go('/send-strk-from-chat?recipientName=theXaxxo Outlook');
                  // Check for transaction result when returning to this screen
                  _checkForTransactionResult();
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

  void _checkForTransactionResult() {
    final transaction = ChatTransactionNotifier.getLastTransaction();
    if (transaction != null) {
      // Add transaction message to chat
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _addTransactionMessage(transaction.amount, transaction.txHash);
        // Clear the transaction so it doesn't get added again
        ChatTransactionNotifier.clearLastTransaction();
      });
    }
  }

  Future<void> _copyToClipboard(String text, BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      
      // Provide haptic feedback
      HapticFeedback.lightImpact();
      
      // Show confirmation snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                AppText('Transaction hash copied!', type: AppTextType.caption, color: Colors.white),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    } catch (e) {
      print('Failed to copy to clipboard: $e');
    }
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

  Widget _buildMessage(Map<String, dynamic> msg, int index) {
    final isMe = msg['fromMe'] as bool;
    final isTransaction = msg['type'] == 'transaction';
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isTransaction 
              ? const Color(0xFFE8F5FF) 
              : isMe 
                  ? const Color(0xFFEDFDF1) 
                  : const Color(0xFFF7F8F9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
          border: isTransaction ? Border.all(color: const Color(0xFF3B82F6), width: 1) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTransaction) ...[
              Row(
                children: [
                  Icon(Icons.currency_exchange, color: const Color(0xFF3B82F6), size: 16),
                  const SizedBox(width: 6),
                  AppText('STRK Transaction', type: AppTextType.captionBold, color: const Color(0xFF3B82F6)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            AppText(
              msg['text'] as String,
              type: AppTextType.caption,
              color: Colors.black,
            ),
            if (isTransaction && msg['txHash'] != null) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _copyToClipboard(msg['txHash'] as String, context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText('Tx Hash:', type: AppTextType.small, color: Colors.black54),
                          const Spacer(),
                          Icon(Icons.copy_rounded, size: 12, color: Colors.black54),
                        ],
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        '${(msg['txHash'] as String).substring(0, 20)}...',
                        type: AppTextType.small,
                        color: const Color(0xFF3B82F6),
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        'Tap to copy',
                        type: AppTextType.small,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (msg['time'] != null && (msg['time'] as String).isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    msg['time'] as String,
                    type: AppTextType.small,
                    color: Colors.black38,
                  ),
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      msg['status'] == 'read' ? Icons.done_all : 
                      msg['status'] == 'delivered' ? Icons.done : Icons.check,
                      size: 16,
                      color: msg['status'] == 'read' ? const Color(0xFF3B82F6) : Colors.black38,
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFFE7F1EA),
                            backgroundImage: const AssetImage('assets/img/avatar-02.png'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      AppText('theXaxxo Outlook', type: AppTextType.small, color: Colors.black54),
                      AppText('Online', type: AppTextType.small, color: const Color(0xFF10B981)),
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
          AppText('Today ${_getCurrentTime()}', type: AppTextType.small, color: Colors.black38),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, i) => _buildMessage(messages[i], i),
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
                                hintText: 'Type a message...',
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
                              onSubmitted: (_) => _sendMessage(),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 36,
                              height: 36,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: _controller.text.trim().isNotEmpty 
                                    ? AppTheme.primaryColor 
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.send_rounded,
                                color: _controller.text.trim().isNotEmpty 
                                    ? Colors.white 
                                    : Colors.grey[600],
                                size: 18,
                              ),
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