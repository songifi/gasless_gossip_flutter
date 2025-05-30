import 'package:flutter/material.dart';
import 'package:gasless_gossip/core/theme/app_theme.dart';
import 'package:gasless_gossip/features/splash/screens/splash_screen.dart';
import 'package:gasless_gossip/features/onboarding/screens/onboarding_screen.dart';
import 'package:gasless_gossip/features/auth/screens/register_screen.dart';
import 'package:gasless_gossip/features/auth/screens/login_screen.dart';
import 'package:gasless_gossip/features/auth/screens/forgot_password_screen.dart';
import 'package:gasless_gossip/features/auth/screens/password_screen.dart';
import 'package:gasless_gossip/features/auth/screens/verify_email_screen.dart';
import 'package:gasless_gossip/features/auth/screens/email_verification_screen.dart';
// import 'package:gasless_gossip/features/auth/screens/success_screen.dart';
import 'package:gasless_gossip/features/auth/screens/register_success_screen.dart';
import 'package:gasless_gossip/features/auth/screens/enter_password_screen.dart';
import 'package:gasless_gossip/features/auth/screens/reset_password_screen.dart';
import 'package:gasless_gossip/features/home/screens/main_layout.dart';
import 'package:gasless_gossip/features/home/screens/send_screen.dart';
import 'package:gasless_gossip/features/home/screens/send_money_screen.dart';
import 'package:gasless_gossip/features/home/screens/send_via_chat_screen.dart';
import 'package:gasless_gossip/features/home/screens/fund_screen.dart';
import 'package:gasless_gossip/features/home/screens/fund_strk_wallet_screen.dart';
import 'package:gasless_gossip/features/home/screens/fund_other_chains_screen.dart';
import 'package:gasless_gossip/features/home/screens/all_nfts_screen.dart';
import 'package:gasless_gossip/features/home/screens/chat_detail_screen.dart';
import 'package:gasless_gossip/features/home/screens/send_strk_from_chat_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/password',
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) => const VerifyEmailScreen(),
    ),
    GoRoute(
      path: '/email-verification',
      builder: (context, state) => const EmailVerificationScreen(),
    ),
    // GoRoute(
    //   path: '/success',
    //   builder: (context, state) => const SuccessScreen(),
    // ),
    GoRoute(
      path: '/register-success',
      builder: (context, state) => const RegisterSuccessScreen(),
    ),
    GoRoute(
      path: '/enter-password',
      builder: (context, state) => const EnterPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainLayout(initialIndex: 0),
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) => const MainLayout(initialIndex: 1),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const MainLayout(initialIndex: 2),
    ),
    GoRoute(
      path: '/nfts',
      builder: (context, state) => const MainLayout(initialIndex: 3),
    ),
    GoRoute(
      path: '/all-nfts',
      builder: (context, state) => const AllNftsScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainLayout(initialIndex: 4),
    ),
    GoRoute(
      path: '/send',
      builder: (context, state) => const SendScreen(),
    ),
    GoRoute(
      path: '/send-money',
      builder: (context, state) => const SendMoneyScreen(),
    ),
    GoRoute(
      path: '/send/via-chat',
      builder: (context, state) => const SendViaChatScreen(),
    ),
    GoRoute(
      path: '/fund',
      builder: (context, state) => const FundScreen(),
    ),
    GoRoute(
      path: '/fund/strk-wallet',
      builder: (context, state) => const FundStrkWalletScreen(),
    ),
    GoRoute(
      path: '/fund/other-chains',
      builder: (context, state) => const FundOtherChainsScreen(),
    ),
    GoRoute(
      path: '/chat-detail',
      builder: (context, state) => const ChatDetailScreen(),
    ),
    GoRoute(
      path: '/send-strk-from-chat',
      builder: (context, state) => SendStrkFromChatScreen(
        recipientName: state.uri.queryParameters['recipientName'] ?? 'Unknown',
        recipientAddress: state.uri.queryParameters['recipientAddress'],
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gasless Gossip',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasless Gossip'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Gasless Gossip',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your decentralized social platform',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement navigation to main features
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
