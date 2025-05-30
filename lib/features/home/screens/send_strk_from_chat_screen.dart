import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:gasless_gossip/services/starknet_service.dart';
import 'package:gasless_gossip/services/chat_transaction_notifier.dart';
import 'package:gasless_gossip/services/price_service.dart';

class SendStrkFromChatScreen extends StatefulWidget {
  final String recipientName;
  final String? recipientAddress;

  const SendStrkFromChatScreen({
    super.key,
    required this.recipientName,
    this.recipientAddress,
  });

  @override
  State<SendStrkFromChatScreen> createState() => _SendStrkFromChatScreenState();
}

class _SendStrkFromChatScreenState extends State<SendStrkFromChatScreen> {
  String _amount = '0';
  bool _isLoading = false;
  String? _transactionHash;
  bool _transactionSent = false;
  double _strkPrice = 1.0;
  bool _isPriceLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStrkPrice();
  }

  Future<void> _loadStrkPrice() async {
    setState(() {
      _isPriceLoading = true;
    });
    
    try {
      final price = await PriceService.getStrkPrice();
      setState(() {
        _strkPrice = price;
        _isPriceLoading = false;
      });
    } catch (e) {
      print('Error loading STRK price: $e');
      setState(() {
        _strkPrice = 1.0; // fallback
        _isPriceLoading = false;
      });
    }
  }

  void _onKeyTap(String key) {
    setState(() {
      if (key == '<') {
        if (_amount.isNotEmpty && _amount != '0') {
          _amount = _amount.substring(0, _amount.length - 1);
          if (_amount.isEmpty) _amount = '0';
        }
      } else if (key == '.') {
        if (!_amount.contains('.')) {
          _amount += key;
        }
      } else {
        if (_amount == '0') {
          _amount = key;
        } else {
          _amount += key;
        }
      }
    });
  }

  Future<void> _sendTransaction() async {
    if (_amount == '0' || _amount.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      print('🔄 Initializing Starknet transaction...');
      print('📍 Account: 0x07a168e677e301B1334408040CD61acDCfc8bF40f460bE7dD4d36b4CdE4aB628');
      print('💰 Amount: $_amount STRK');
      
      // REAL transactions on Sepolia testnet with user's credentials:
      final starknetService = StarknetService();
      
      print('⚙️ Initializing account...');
      await starknetService.initializeAccount(
        privateKey: "0x031a5b08d72e93bb7408a19b1b1ed250f3ce533c8446ccf7156e8bcdc156e46c",
        accountAddress: "0x07a168e677e301B1334408040CD61acDCfc8bF40f460bE7dD4d36b4CdE4aB628",
      );
      
      print('🔍 Checking account status...');
      await starknetService.isAccountDeployed("0x07a168e677e301B1334408040CD61acDCfc8bF40f460bE7dD4d36b4CdE4aB628");
      
      print('💰 Checking balances...');
      await starknetService.checkBalances("0x07a168e677e301B1334408040CD61acDCfc8bF40f460bE7dD4d36b4CdE4aB628");
      
      print('💸 Sending transaction...');
      final result = await starknetService.sendStrk(
        recipientAddress: DemoStarknetService.demoUsers[widget.recipientName] ?? 
                         "0x07394cbe418daa16e42b87ba67372d4ab4a5df0b05c6e554d158458ce245bc10",
        amount: _amount,
      );

      // For DEMO mode (commented out):
      // final result = await DemoStarknetService.sendStrkDemo(
      //   recipientName: widget.recipientName,
      //   amount: _amount,
      // );

      setState(() {
        _isLoading = false;
        _transactionSent = result.success;
        _transactionHash = result.transactionHash;
      });

      if (result.success) {
        // Print transaction hash to console
        print('✅ Transaction successful!');
        print('📋 Transaction Hash: ${result.transactionHash}');
        print('💰 Amount: $_amount STRK');
        print('👤 Recipient: ${widget.recipientName}');
        
        // Show success dialog
        _showSuccessDialog(result.transactionHash!);
      } else {
        print(result.message);
        // Show error dialog
        _showErrorDialog(result.message);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to send transaction: $e');
    }
  }

  void _showSuccessDialog(String txHash) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              AppText(
                'Transaction Successful!',
                type: AppTextType.body,
                color: Colors.black,
              ),
              const SizedBox(height: 8),
              AppText(
                'You sent ${double.tryParse(_amount)?.toStringAsFixed(2) ?? _amount} STRK to ${widget.recipientName}',
                type: AppTextType.caption,
                color: Colors.black54,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText('Transaction Hash:', type: AppTextType.captionBold, color: Colors.black54),
                        const Spacer(),
                        Icon(Icons.copy_rounded, size: 16, color: Colors.black54),
                      ],
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _copyToClipboard(txHash, context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: AppText(
                          '${txHash.substring(0, 30)}...',
                          type: AppTextType.small,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      'Tap to copy full hash',
                      type: AppTextType.small,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.go('/chat-detail');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: AppText('Back to Chat', type: AppTextType.captionBold, color: AppTheme.primaryColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Store transaction data for chat to pickup
                        _storeTransactionResult(txHash);
                        context.go('/chat-detail');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: AppText('View in Chat', type: AppTextType.captionBold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _storeTransactionResult(String txHash) {
    // In a real app, you would use a state manager like Provider, Riverpod, or Bloc
    // For now, we'll use a simple static variable
    ChatTransactionNotifier.setLastTransaction(
      amount: double.tryParse(_amount)?.toStringAsFixed(2) ?? _amount,
      txHash: txHash,
      timestamp: DateTime.now(),
    );
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 24),
            const SizedBox(width: 8),
            AppText('Transaction Failed', type: AppTextType.h5, color: Colors.black),
          ],
        ),
        content: AppText(message, type: AppTextType.body, color: Colors.black87),
        actions: [
          AppButton(
            label: 'Try Again',
            onPressed: () => Navigator.of(context).pop(),
            type: AppButtonType.secondary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/chat-detail"),
        ),
        title: AppText('Send STRK', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Recipient info
          CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            backgroundImage: const AssetImage('assets/img/avatar-02.png'),
          ),
          const SizedBox(height: 12),
          AppText(widget.recipientName, type: AppTextType.h4, color: AppTheme.primaryColor),
          const SizedBox(height: 32),
          
          // Amount display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                AppText('Amount', type: AppTextType.caption, color: Colors.black54),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      _amount,
                      type: AppTextType.h1,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppText('STRK', type: AppTextType.h4, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _isPriceLoading 
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 8),
                        AppText('Loading price...', type: AppTextType.caption, color: Colors.black54),
                      ],
                    )
                  : AppText(
                      PriceService.formatUsdAmount(double.tryParse(_amount) ?? 0, _strkPrice),
                      type: AppTextType.caption, 
                      color: Colors.black54,
                    ),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Keypad
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _KeypadRow(keys: ['1', '2', '3'], onTap: _onKeyTap),
                  const SizedBox(height: 20),
                  _KeypadRow(keys: ['4', '5', '6'], onTap: _onKeyTap),
                  const SizedBox(height: 20),
                  _KeypadRow(keys: ['7', '8', '9'], onTap: _onKeyTap),
                  const SizedBox(height: 20),
                  _KeypadRow(keys: ['.', '0', '<'], onTap: _onKeyTap),
                ],
              ),
            ),
          ),
          
          // Send button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                label: _isLoading ? 'Sending...' : 'Send STRK',
                onPressed: _isLoading ? null : _sendTransaction,
                type: AppButtonType.primary,
                loading: _isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeypadRow extends StatelessWidget {
  final List<String> keys;
  final void Function(String) onTap;
  
  const _KeypadRow({required this.keys, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((k) {
        return GestureDetector(
          onTap: () => onTap(k),
          child: Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              shape: BoxShape.circle,
            ),
            child: k == '<'
                ? const Icon(Icons.backspace_outlined, size: 28, color: Colors.black54)
                : AppText(k, type: AppTextType.h4, color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
} 