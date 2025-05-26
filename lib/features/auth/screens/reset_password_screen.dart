import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go('/email-verification'),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF6E5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  'In order to protect your account, you might not be able to send STRK or NFTs until after 24 hours if you reset your password',
                  type: AppTextType.caption,
                  color: Colors.green,
                ),
              ),
              AppInput(
                hintText: 'New Password',
                controller: _passwordController,
                isPassword: true,
                borderColor: const Color(0xFFDBE1E7),
                fillColor: const Color(0xFFF7F8F9),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  _PasswordRequirement(text: '8 Characters', met: true),
                  _PasswordRequirement(text: '1 Uppercase Letter'),
                  _PasswordRequirement(text: '1 Lowercase Letter'),
                  _PasswordRequirement(text: '1 Special Character'),
                  _PasswordRequirement(text: '1 Number Character'),
                ],
              ),
              const SizedBox(height: 16),
              AppInput(
                hintText: 'Confirm Password',
                controller: _confirmPasswordController,
                isPassword: true,
                borderColor: const Color(0xFFDBE1E7),
                fillColor: const Color(0xFFF7F8F9),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Confirm',
                  loading: _loading,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  final String text;
  final bool met;
  const _PasswordRequirement({required this.text, this.met = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: met ? Color(0xFFF6FEF8) : Colors.transparent,
        border: Border.all(
          color: met ? Color(0xFFC8F9D4) : const Color(0xFFDBE1E7),
          width: 1,
          style: met ? BorderStyle.solid : BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText(
        text,
        type: AppTextType.caption,
        color: met ? Theme.of(context).colorScheme.primary : Colors.black54,
      ),
    );
  }
} 