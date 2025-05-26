import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go('/login'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              AppText('Reset password', type: AppTextType.h3),
              const SizedBox(height: 8),
              AppText(
                'To reset your password, enter your email: o****@gmail.com. Note that some activities might be disabled until after 24 hours to protect your account in order to protect your account.',
                type: AppTextType.caption,
                color: Colors.black54,
              ),
              const SizedBox(height: 24),
              AppInput(
                hintText: 'Email',
                controller: _emailController,
                isPassword: true,
                borderColor: const Color(0xFFDBE1E7),
                fillColor: const Color(0xFFF7F8F9),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Continue',
                  loading: _loading,
                  onPressed: () {
                    context.go("/email-verification");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 