import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_presence_flutter2/app/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:online_presence_flutter2/app/firebase/realtime_database/realtime_database_service.dart';
import 'package:online_presence_flutter2/app/user/user_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.watch(firebaseAuthServiceProvider),
    ref.watch(userServiceProvider),
    ref.watch(realtimeDatabaseServiceProvider),
  );
});

class AuthService {
  AuthService(this._firebaseAuthService, this._userService,
      this._realtimeDatabaseService);

  final FirebaseAuthService _firebaseAuthService;
  final UserService _userService;
  final RealtimeDatabaseService _realtimeDatabaseService;

  Future<void> signUpAnonymously() async {
    final currentUserId = await _firebaseAuthService.signUpAnonymously();
    await _userService.setUser(currentUserId);
    await _realtimeDatabaseService.updateUserPresence(currentUserId);
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  String get currentUserId => _firebaseAuthService.currentUserId!;
}
