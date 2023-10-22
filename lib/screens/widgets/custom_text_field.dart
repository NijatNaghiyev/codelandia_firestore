import 'package:flutter/material.dart';

import '../../constants/input_decorations.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  const CustomTextField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: AppInputDecorations.inputDecorationEmail,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              autocorrect: false,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: AppInputDecorations.inputDecorationPassword,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length < 6) {
                  return 'Please enter a valid password (at least 6 characters)';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
