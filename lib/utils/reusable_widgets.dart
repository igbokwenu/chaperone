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
