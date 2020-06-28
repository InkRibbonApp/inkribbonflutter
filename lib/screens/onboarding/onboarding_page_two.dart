import 'package:flutter/material.dart';
import 'package:flutter_hackathon/text_styles.dart';

class OnboardingPageTwo extends StatelessWidget {
  final String title = 'Paperless application to care for the environment';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/paper/paper.png'),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return _buildForLandscsape();
                } else {
                  return _buildForPortrait();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForLandscsape() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/onboarding/trash.png',
            width: 150,
            height: 200,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              title,
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
            title,
            style: kOnboardingTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
