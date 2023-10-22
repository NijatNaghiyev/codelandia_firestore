import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Welcome: ${FirebaseAuth.instance.currentUser!.email}',
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
