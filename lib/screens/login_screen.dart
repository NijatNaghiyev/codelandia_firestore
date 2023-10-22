import 'package:codelandia_firestore/screens/home_screen.dart';
import 'package:codelandia_firestore/screens/singup_screen.dart';
import 'package:codelandia_firestore/screens/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (!mounted) {
          return;
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
        isLoading = false;
      } on FirebaseAuthException catch (e) {
        if (!mounted) {
          return;
        }
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found for that email.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong.'),
            ),
          );
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/icon.png',
                  width: MediaQuery.sizeOf(context).width / 2,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Login'),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: !isLoading,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
