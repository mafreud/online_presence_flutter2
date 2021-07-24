import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_presence_flutter2/app/auth/auth_service.dart';

final welcomePageViewModelProvider = Provider<WelcomePageViewModel>((ref) {
  return WelcomePageViewModel(ref.watch(authServiceProvider));
});

class WelcomePageViewModel {
  WelcomePageViewModel(this._authService);

  final AuthService _authService;

  Future<void> signUpAnonymously() async {
    await _authService.signUpAnonymously();
  }
}
