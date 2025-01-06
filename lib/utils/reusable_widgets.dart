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
