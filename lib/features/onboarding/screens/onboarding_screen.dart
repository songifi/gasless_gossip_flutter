import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      image: 'assets/img/onboarding-01.png',
      title: 'Chat Securely, Send Instantly',
      description: 'Talk with friends or communities using end-to-end encrypted wallet-to-wallet messaging.',
    ),
    _OnboardingPage(
      image: 'assets/img/onboarding-02.png',
      title: 'Send STRK Like You Send Emojis',
      description: 'Tip friends, split bills, or gift NFTs directly in the chat.',
    ),
    _OnboardingPage(
      image: 'assets/img/onboarding-03.png',
      title: 'Collect and Store your NFTs',
      description: 'Show off your digital treasures with ease. Gasless Gossip lets you receive, view, and store NFTs',
    ),
  ];

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Navigate to register screen
      context.go('/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (context, i) {
                final page = _pages[i];
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Image.asset(
                          page.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          AppText(
                            page.title,
                            type: AppTextType.h3,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          AppText(
                            page.description,
                            type: AppTextType.body,
                            color: Colors.black54,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_pages.length, (j) {
                              final isActive = j == _page;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              label: i == _pages.length - 1 ? 'Sign Up' : 'Next',
                              onPressed: _next,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String image;
  final String title;
  final String description;
  const _OnboardingPage({required this.image, required this.title, required this.description});
} 