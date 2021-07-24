import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../color/custom_colors.dart';
import '../online_presence/online_presence_page.dart';
import 'welcome_page_view_model.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.navy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Icon(),
            _Title(),
            _Button(),
          ],
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Image.asset('assets/images/toggle.png'),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: Text(
        'isOnline?',
        style: TextStyle(
            color: CustomColors.grey,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _Button extends ConsumerWidget {
  const _Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(welcomePageViewModelProvider);
    return SizedBox(
      width: 170,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.blue,
        ),
        onPressed: () async {
          viewModel.signUpAnonymously();
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OnlinePresencePage(),
              ));
        },
        child: Text(
          'はじめる',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
