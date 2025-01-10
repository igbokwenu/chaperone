import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/views/compliance_views/contact_view.dart';
import 'package:chaperone/views/compliance_views/privacy_policy_view.dart';
import 'package:chaperone/views/compliance_views/terms_view.dart';
import 'package:flutter/material.dart';

class LegalLinksWidget extends StatelessWidget {
  const LegalLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyView()),
              );
            },
            child: const Text('Privacy', style: TextStyle(color: Colors.white)),
          ),
          const Text('|', style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsView()),
              );
            },
            child: const Text('Terms', style: TextStyle(color: Colors.white)),
          ),
          const Text('|', style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactView()),
              );
            },
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class AgreementTextWidget extends StatelessWidget {
  const AgreementTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'By proceeding, you agree to our privacy policy and terms',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ChaperoneLogoImageWidget extends StatelessWidget {
  const ChaperoneLogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: 400,
      fit: BoxFit.contain,
    );
  }
}

class AppStoreButtonsWidget extends StatelessWidget {
  const AppStoreButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            MyReusableFunctions.launchCustomUrl(
                url:
                    'https://play.google.com/store/apps/details?id=com.increasedw.chaperone');
          },
          child: Image.asset(
            'assets/images/play_store_onlight.png',
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            MyReusableFunctions.launchCustomUrl(
                url:
                    'https://apps.apple.com/us/app/chaperone-stories-by-you/id6740037309');
          },
          child: Image.asset(
            'assets/images/app_store_onlight.png',
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class AnimatedButtonText extends StatefulWidget {
  const AnimatedButtonText({super.key});

  @override
  AnimatedButtonTextState createState() => AnimatedButtonTextState();
}

class AnimatedButtonTextState extends State<AnimatedButtonText> {
  bool _showFirstText = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showFirstText = !_showFirstText;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const Text(
        'Create A Game',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      secondChild: const Text(
        'Tell Your Story',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      crossFadeState:
          _showFirstText ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }
}
