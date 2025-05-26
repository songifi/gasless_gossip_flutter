import 'package:flutter/material.dart';
import 'package:gasless_gossip/shared/widgets/app_text.dart';
import 'package:gasless_gossip/shared/widgets/app_button.dart';
import 'package:gasless_gossip/shared/widgets/app_input.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _agreed = true;
  final bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              AppText(
                'Welcome to \nGasless Gossip',
                type: AppTextType.h3,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 32),
              AppInput(
                hintText: 'Email/Phone',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                borderColor: const Color(0xFFDBE1E7),
                fillColor: const Color(0xFFF7F8F9),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(-8, 0),
                    child: Checkbox(
                      value: _agreed,
                      onChanged: (v) => setState(() => _agreed = v ?? false),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      side: const BorderSide(color: Color(0xFFDBE1E7), width: 2),
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      "By creating an account, I agree to Gasless Gossip's Terms of Service and Privacy Policy",
                      type: AppTextType.caption,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Next',
                  loading: _loading,
                  onPressed: _agreed ? () {
                    context.go('/verify-email');
                  } : null,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFDBE1E7))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppText('OR', type: AppTextType.caption),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFDBE1E7))),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.asset('assets/img/google-icon.png', height: 20),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    side: BorderSide(color: Colors.grey.shade300),
                    backgroundColor: const Color(0xFFF7F8F9),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.asset('assets/img/apple-icon.png', height: 20),
                  label: const Text('Continue with Apple'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    side: BorderSide(color: Colors.grey.shade300),
                    backgroundColor: const Color(0xFFF7F8F9),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.go('/login');
                  },
                  child: AppText(
                    'Already have an account?  Log In',
                    type: AppTextType.caption,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
} 