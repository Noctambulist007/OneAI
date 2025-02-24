import 'package:flutter/material.dart';
import 'package:one_ai/features/auth/widget/auth_button.dart';
import 'package:one_ai/features/auth/widget/auth_header.dart';
import 'package:one_ai/features/auth/widget/auth_text_field.dart';
import 'package:one_ai/features/auth/widget/google_sign_in_button.dart';
import 'package:one_ai/features/home/screen/home_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/utils/validation/validations.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';
import 'package:one_ai/features/auth/widget/auth_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.colorSurface,
      body: Form(
        key: _formKey,
        child: AuthBackground(
          animationController: _animationController,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    AuthHeader(
                      icon: Icons.person_add_outlined,
                      title: 'Create Account',
                      subtitle: 'Join us on your journey',
                      fadeAnimation: _fadeAnimation,
                      slideAnimation: _slideAnimation,
                    ),
                    SizedBox(height: size.height * 0.03),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              AuthTextField(
                                controller: _firstNameController,
                                label: 'First Name',
                                hint: 'John',
                                icon: Icons.person_outline,
                                validator: ValidationUtils.validateName,
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                controller: _lastNameController,
                                label: 'Last Name',
                                hint: 'Doe',
                                icon: Icons.person_outline,
                                validator: ValidationUtils.validateName,
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'example@email.com',
                                icon: Icons.email_outlined,
                                validator: ValidationUtils.validateEmail,
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                controller: _passwordController,
                                label: 'Password',
                                hint: '••••••',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                obscureText: _obscurePassword,
                                onTogglePassword: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                                validator: ValidationUtils.validatePassword,
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                controller: _confirmPasswordController,
                                label: 'Confirm Password',
                                hint: '••••••',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                obscureText: _obscureConfirmPassword,
                                onTogglePassword: () => setState(() =>
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword),
                                validator: _validateConfirmPassword,
                              ),
                              const SizedBox(height: 24),
                              AuthButton(
                                onPressed: _handleSignUp,
                                isLoading: _isLoading,
                                text: 'Sign Up',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                          color:
                                              Colors.black.withOpacity(0.1))),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('Or',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  Expanded(
                                      child: Divider(
                                          color:
                                              Colors.black.withOpacity(0.1))),
                                ],
                              ),
                              const SizedBox(height: 16),
                              GoogleSignInButton(
                                onPressed: _handleGoogleSignIn,
                                isLoading: _isLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final error = await authProvider.signUpWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please verify your email.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final error = await authProvider.signInWithGoogle();

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
