import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import '../widgets/nft_card.dart';
import 'package:go_router/go_router.dart';

class AllNftsScreen extends StatefulWidget {
  const AllNftsScreen({super.key});

  @override
  State<AllNftsScreen> createState() => _AllNftsScreenState();
}

class _AllNftsScreenState extends State<AllNftsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  final List<Map<String, String>> nfts = [
    {
      'image': 'assets/img/avatar-01.png',
      'name': 'Ganger Gangsta',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-02.png',
      'name': 'Nerdy Freddy Mendy',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-01.png',
      'name': 'Ganger Gangsta',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-02.png',
      'name': 'Nerdy Freddy Mendy',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-01.png',
      'name': 'Ganger Gangsta',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-02.png',
      'name': 'Nerdy Freddy Mendy',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-01.png',
      'name': 'Ganger Gangsta',
      'price': '24.89',
    },
    {
      'image': 'assets/img/avatar-02.png',
      'name': 'Nerdy Freddy Mendy',
      'price': '24.89',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredNfts = nfts.where((nft) => nft['name']!.toLowerCase().contains(_search.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go("/home"),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppText('All NFTs', type: AppTextType.h5, color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppInput(
                    controller: _searchController,
                    hintText: 'Search...',
                    borderColor: const Color(0xFFDBE1E7),
                    fillColor: const Color(0xFFF7F8F9),
                    onChanged: (val) => setState(() => _search = val),
                    prefixIcon: Icon(Icons.search, color: Colors.black38),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: filteredNfts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, i) {
                  final nft = filteredNfts[i];
                  return NftCard(
                    imagePath: nft['image']!,
                    name: nft['name']!,
                    price: nft['price']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 