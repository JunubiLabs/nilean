import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final String terms = """
  ### Introduction
  These Terms and Conditions ("Terms") govern your use of our mobile app (the "App") and any services provided through it. By using the App, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the App.

  ### Definitions
  - **App**: The mobile application developed by Joseph Gakah @neurollect, a cooperation of NileCore.
  - **User**: Any individual who downloads, installs, or uses the App.
  - **Services**: The e-learning services and features provided through the App.

  ### License to Use
  We grant you a non-exclusive, non-transferable license to use the App for personal, non-commercial purposes. You agree not to modify, copy, or distribute the App without our prior written consent.

  ### Acceptable Use
  You must use the App in compliance with all applicable laws and regulations. You agree not to use the App for any unlawful or unauthorized purpose.

  ### Prohibited Conduct
  You are prohibited from:
  - Using the App in a way that could damage, disable, overburden, or impair the App or interfere with any other party's use of the App.
  - Attempting to gain unauthorized access to the App or any part of it.
  - Using the App to transmit or upload any viruses, Trojan horses, or other malicious code.

  ### Termination and Account Suspension
  We reserve the right to terminate or suspend your access to the App at any time, without notice, if you breach these Terms or for any other reason.

  ### Intellectual Property Protection
  All intellectual property rights in the App and its content are owned by us or our licensors. You agree not to infringe these rights.

  ### User-Generated Content
  If the App allows you to create or upload content, you grant us a non-exclusive, perpetual license to use, modify, and distribute such content. You warrant that you have the right to grant this license.

  ### Payment Clauses
  If the App offers paid services, payment terms will be clearly outlined at the time of purchase.

  ### Privacy Policy
  Our Privacy Policy, which is incorporated into these Terms, explains how we collect, use, and protect your personal information. Please review our Privacy Policy for more details.

  ### Limitation of Liability
  We are not liable for any damages arising from your use of the App, except to the extent required by applicable law.

  ### Disclaimers and Warranties
  The App is provided "as is" without warranties of any kind. We disclaim all warranties, express or implied.

  ### Governing Law
  These Terms are governed by and construed in accordance with the laws. Any disputes arising from these Terms will be resolved through [Dispute Resolution Process].

  ### Changes to These Terms
  We may update these Terms from time to time. We will notify you of any material changes by posting a notice on the App or sending you an email.

  ### Contact Us
  If you have any questions or concerns about these Terms, please contact us at [info@neurollect.africa](mailto:info@neurollect.africa).

""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButtons.backButton(onPressed: () {
                Navigator.pop(context);
              }),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Terms and Conditions',
                subtitle: '',
                context: context,
              ),
              MarkdownBody(data: terms),
            ],
          ),
        ),
      ),
    );
  }
}
