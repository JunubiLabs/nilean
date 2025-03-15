import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nilean/ui/widgets/app_buttons.dart';

class PriacyPolicyPage extends StatefulWidget {
  const PriacyPolicyPage({super.key});

  @override
  State<PriacyPolicyPage> createState() => _PriacyPolicyPageState();
}

class _PriacyPolicyPageState extends State<PriacyPolicyPage> {
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
              MarkdownBody(data: 'data'),
            ],
          ),
        ),
      ),
    );
  }
}
