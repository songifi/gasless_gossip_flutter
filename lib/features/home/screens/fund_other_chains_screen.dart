import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';

class FundOtherChainsScreen extends StatefulWidget {
  const FundOtherChainsScreen({super.key});

  @override
  State<FundOtherChainsScreen> createState() => _FundOtherChainsScreenState();
}

class _FundOtherChainsScreenState extends State<FundOtherChainsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredChains = [];

  final List<Map<String, dynamic>> _chains = [
    {
      'name': 'Arbitrum One',
      'icon': Icons.circle,
      'color': const Color(0xFF2D374B),
    },
    {
      'name': 'Base',
      'icon': Icons.circle,
      'color': const Color(0xFF0052FF),
    },
    {
      'name': 'Ethereum',
      'icon': Icons.diamond,
      'color': const Color(0xFF627EEA),
    },
    {
      'name': 'Immutable zkEVM',
      'icon': Icons.circle,
      'color': Colors.black,
    },
    {
      'name': 'Abstract',
      'icon': Icons.circle,
      'color': const Color(0xFF00D4AA),
    },
    {
      'name': 'Arbitrum Nova',
      'icon': Icons.circle,
      'color': const Color(0xFFFF6B35),
    },
    {
      'name': 'Avalanche',
      'icon': Icons.circle,
      'color': const Color(0xFFE84142),
    },
    {
      'name': 'BSC',
      'icon': Icons.circle,
      'color': const Color(0xFFF3BA2F),
    },
    {
      'name': 'Blast',
      'icon': Icons.circle,
      'color': Colors.black,
    },
    {
      'name': 'Bob',
      'icon': Icons.circle,
      'color': const Color(0xFFFF6B35),
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredChains = _chains;
    _searchController.addListener(_filterChains);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterChains() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChains = _chains.where((chain) {
        return chain['name'].toLowerCase().contains(query);
      }).toList();
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
          onPressed: () => context.go("/fund"),
        ),
        title: AppText('From Other Chains', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Select from the listed chains below how you which you like to fund your wallet.',
                  type: AppTextType.caption,
                  color: const Color(0xFF6B7280),
                ),
                const SizedBox(height: 24),
                Container(
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
                      prefixIcon: Icon(Icons.search, color: Color(0xFF6B7280)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _filteredChains.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFFE5E7EB),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final chain = _filteredChains[index];
                return _buildChainItem(
                  name: chain['name'],
                  icon: chain['icon'],
                  color: chain['color'],
                  onTap: () {
                    // Handle chain selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChainItem({
    required String name,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppText(name, type: AppTextType.body, color: Colors.black),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF6B7280), size: 16),
          ],
        ),
      ),
    );
  }
} 