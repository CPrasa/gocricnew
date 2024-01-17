import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/welcome_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 60),
                        child: Image.asset(
                          'assets/logo/logo.png',
                          height: 80.0,
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Welcome Back!\n',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            TextSpan(
                                text: '\nFor cricket lovers',
                                style: TextStyle(
                                  fontSize: 20,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'LOG IN',
                      onTap: SignInScreen(),
                      color: Colors.white,
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'SIGN UP',
                      onTap: SignUpScreen(),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
