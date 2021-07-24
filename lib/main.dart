import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_presence_flutter2/app/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:online_presence_flutter2/app/online_presence/online_presence_page.dart';

import 'app/welcome/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _AuthFlowWidget(),
    );
  }
}

class _AuthFlowWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final firebaseAuthService = watch(firebaseAuthServiceProvider);
    return StreamBuilder<User?>(
      stream: firebaseAuthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        return _data(context, data);
      },
    );
  }

  Widget _data(BuildContext context, User? user) {
    if (user != null) {
      return OnlinePresencePage();
    }
    return WelcomePage();
  }
}
