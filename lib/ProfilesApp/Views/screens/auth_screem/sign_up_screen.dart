import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_list_app/ProfilesApp/Views/screens/auth_screem/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscure = true;
  bool _isConfirmObscure = true;

  // ---------- VALIDATORS ----------
  String? _validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your username';
    }
    if (value.length < 3) return 'At least 3 characters required';
    return null;
  }

  String? _validateContact(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter contact number';
    final contactRegex = RegExp(r'^\d{10,15}$');
    if (!contactRegex.hasMatch(value)) return 'Enter a valid number';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your email';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 6) return 'At least 6 characters required';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passController.text) return 'Passwords do not match';
    return null;
  }

  // ---------- SAVE USER DATA ----------
  Future<void> _submitSignUp() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String userId = DateTime.now().millisecondsSinceEpoch.toString();

      await prefs.setString('userId', userId);
      await prefs.setString(
        'email',
        _emailController.text.trim().toLowerCase(),
      );
      await prefs.setString('password', _passController.text.trim());
      await prefs.setString(
        'username',
        _userNameController.text.trim(),
      ); // ✅ match exactly

      await prefs.setString('contact', _contactController.text.trim());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign Up Successful')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void _goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  // ---------- REUSABLE TEXT FIELD ----------
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    VoidCallback? toggleVisibility,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon:
            toggleVisibility != null
                ? IconButton(
                  icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: toggleVisibility,
                )
                : null,
      ),
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
    );
  }

  // ---------- GOOGLE SIGN-IN BUTTON ----------
  Widget _googleButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset('icon/google-logo.png', width: 20, height: 20),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Sign Up'),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _userNameController,
                      label: 'User Name',
                      icon: Icons.person,
                      validator: _validateUserName,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _contactController,
                      label: 'Contact No',
                      icon: Icons.phone,
                      validator: _validateContact,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passController,
                      label: 'Password',
                      icon: Icons.lock,
                      obscure: _isObscure,
                      toggleVisibility:
                          () => setState(() => _isObscure = !_isObscure),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _confirmPassController,
                      label: 'Confirm Password',
                      icon: Icons.lock,
                      obscure: _isConfirmObscure,
                      toggleVisibility:
                          () => setState(
                            () => _isConfirmObscure = !_isConfirmObscure,
                          ),
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 24),
                    _googleButton(),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _submitSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.blueAccent),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _goToLogin,
                      child: const Text('Already have an account? Login'),
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
}
