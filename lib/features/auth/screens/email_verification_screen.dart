import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _loading = false;
  bool _resent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => context.go('/forgot-password'),
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
              AppText('Email verification', type: AppTextType.h3),
              const SizedBox(height: 8),
              AppText(
                'A 6-digit code has been sent to oluwatimzy371@gmail.com. Please enter it within the next 30 minutes.',
                type: AppTextType.caption,
                color: Colors.black54,
              ),
              const SizedBox(height: 24),
              AppInput(
                hintText: 'Verification Code',
                controller: _codeController,
                keyboardType: TextInputType.number,
                borderColor: const Color(0xFFDBE1E7),
                fillColor: const Color(0xFFF7F8F9),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Next',
                  loading: _loading,
                  onPressed: () {
                    context.go("/reset-password");
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      "Didn't receive code ",
                      type: AppTextType.caption,
                      color: Colors.black54,
                    ),
                    GestureDetector(
                      onTap: _resent
                          ? null
                          : () {
                              setState(() => _resent = true);
                            },
                      child: AppText(
                        'Resend',
                        type: AppTextType.captionBold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 