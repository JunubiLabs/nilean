import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';
import 'package:nilean/ui/widgets/app_texts.dart';

class PriacyPolicyPage extends StatefulWidget {
  const PriacyPolicyPage({super.key});

  @override
  State<PriacyPolicyPage> createState() => _PriacyPolicyPageState();
}

class _PriacyPolicyPageState extends State<PriacyPolicyPage> {
  final info = """
At Neurollect, we take your privacy and data security seriously. This Data and Privacy Statement explains how we collect, use, and protect your personal information and data when you use our e-learning app.

We collect personal information that you voluntarily provide to us when you use our app, such as your name, email address, and educational background. We may also collect information about your device, IP address, and browser type.

## How We Use Your Personal Information
We use your personal information to provide and improve our e-learning services, to communicate with you, and to personalize your learning experience. We may also use your information to send you promotional emails or newsletters, but you can opt-out at any time.

## How We Protect Your Personal Informationzzzz
We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. We use industry-standard security measures such as encryption and firewalls to protect your data.

## How We Share Your Personal Information
We may share your personal information with third-party service providers to help us provide our e-learning services, such as hosting and data analytics. We may also share your information with law enforcement or other third parties when required by law or to protect our rights and property.

## Your Choices and Rights
You can update or delete your personal information at any time by contacting us. You can also opt-out of receiving promotional emails or newsletters by following the instructions in the email. You have the right to access, correct, or delete your personal information under applicable data protection laws.

## Changes to this Data and Privacy Statement
We may update this Data and Privacy Statement from time to time. We will notify you of any material changes by posting a notice on our app or sending you an email.

## Contact Us
If you have any questions or concerns about this Data and Privacy Statement, please contact us at [info@neurollect.africa](mailto:Info@neurollect.africa).

## Thank you for using Neurollect!
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
              AppButtons.backButton(onPressed: () {}),
              const SizedBox(height: 20),
              AppTexts.sectionTitle(
                title: 'Privacy Policy',
                subtitle: '',
                context: context,
              ),
              const SizedBox(height: 20),
              MarkdownBody(data: info),
            ],
          ),
        ),
      ),
    );
  }
}
