import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/views/auth_views/signin_view.dart';
import 'package:chaperone/views/auth_views/signup_view.dart';
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpView(
                    authService: authService,
                    isAnonymous: authService.isUserAnonymous(),
                  ),
                ),
              );
            },
            child: Text(
              'New player? Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16), // Adds spacing between the buttons
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInView(authService: authService),
                ),
              );
            },
            child: Text(
              'Existing? Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
