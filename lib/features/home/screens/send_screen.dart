import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import '../widgets/nft_send_card.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  int _tabIndex = 0; // 0 = STRK, 1 = NFT
  String _amount = '280.00'; // default for demo
  final recipient = {
    'name': 'Anna',
    'image': 'assets/img/avatar-01.png',
  };
  final nfts = List.generate(12, (i) => {
    'image': 'assets/img/avatar-01.png',
    'name': 'Ganger Gangsta',
    'price': '24.89',
  });
  final String strkBalance = '12,678.97 STRK';

  void _onKeyTap(String key) {
    setState(() {
      if (key == '<') {
        if (_amount.isNotEmpty) {
          _amount = _amount.substring(0, _amount.length - 1);
          if (_amount.isEmpty) _amount = '0';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/home"),
        ),
        title: AppText('Send', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat_outlined, color: AppTheme.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDBE1E7)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Row(
                children: [
                  _SendTab(
                    label: 'Send STRK',
                    selected: _tabIndex == 0,
                    onTap: () => setState(() => _tabIndex = 0),
                  ),
                  _SendTab(
                    label: 'Send NFT',
                    selected: _tabIndex == 1,
                    onTap: () => setState(() => _tabIndex = 1),
                  ),
                ],
              ),
              )
            ),
          ),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(recipient['image']!),
          ),
          const SizedBox(height: 12),
          AppText(recipient['name']!, type: AppTextType.h4, color: AppTheme.primaryColor),
          const SizedBox(height: 16),
          if (_tabIndex == 0) ...[
            AppText('How much?', type: AppTextType.small, color: Colors.black54),
            const SizedBox(height: 8),
            AppText('\$ ${_amount.isEmpty ? '0' : _amount}', type: AppTextType.h1, color: Colors.black, textAlign: TextAlign.center),
            const SizedBox(height: 4),
            AppText(strkBalance, type: AppTextType.small, color: Colors.black38),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _KeypadRow(keys: const ['1', '2', '3'], onTap: _onKeyTap),
                  const SizedBox(height: 16),
                  _KeypadRow(keys: const ['4', '5', '6'], onTap: _onKeyTap),
                  const SizedBox(height: 16),
                  _KeypadRow(keys: const ['7', '8', '9'], onTap: _onKeyTap),
                  const SizedBox(height: 16),
                  _KeypadRow(keys: const ['', '0', '<'], onTap: _onKeyTap),
                ],
              ),
            ),
          ],
          if (_tabIndex == 1) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border.all(color: const Color(0xFFDBE1E7)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Cancel', type: AppTextType.caption, color: Colors.black54),
                  AppText('Your NFTs (24)', type: AppTextType.captionBold, color: AppTheme.primaryColor),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFF7F8F9),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: nfts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, i) {
                    final nft = nfts[i];
                    return NftSendCard(
                      imagePath: nft['image']!,
                      price: nft['price']!,
                    );
                  },
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Send',
                onPressed: () {},
                type: AppButtonType.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SendTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SendTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AppText(
              label,
              type: AppTextType.caption,
              color: selected ? AppTheme.primaryColor : Colors.black54,
            ),
          ),
        ),
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
        if (k.isEmpty) {
          return const SizedBox(width: 64);
        }
        return GestureDetector(
          onTap: () => onTap(k),
          child: Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            child: k == '<'
                ? const Icon(Icons.backspace_outlined, size: 28)
                : AppText(k, type: AppTextType.h4, color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
} 