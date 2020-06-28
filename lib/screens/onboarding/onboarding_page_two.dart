import 'package:flutter/material.dart';
import 'package:flutter_hackathon/text_styles.dart';

class OnboardingPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildForLandscsape();
        } else {
          return _buildForPortrait();
        }
      },
    );
  }

  Widget _buildForLandscsape() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/onboarding/trash.png',
            width: 150,
            height: 200,
          ),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              'Care about the environment by writing your precious ideas paperless',
              style: kOnboardingTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForPortrait() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 32.0, right: 32.0),
      child: Column(
        children: [
          Image.asset(
            'assets/onboarding/trash.png',
            width: 200,
            height: 300,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Care about the environment by writing your precious ideas paperless',
            style: kOnboardingTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
