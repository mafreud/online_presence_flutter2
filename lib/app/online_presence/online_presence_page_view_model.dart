import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_presence_flutter2/app/auth/auth_service.dart';
import 'package:online_presence_flutter2/app/firebase/cloud_firestore/cloud_firestore_service.dart';
import 'package:online_presence_flutter2/app/firebase/cloud_firestore/firestore_path.dart';
import 'package:online_presence_flutter2/app/firebase/realtime_database/realtime_database_service.dart';
import 'package:online_presence_flutter2/app/user/user_model.dart';

final onlinePresencePageViewModelProvider =
    Provider<OnlinePresencePageViewModel>((ref) {
  return OnlinePresencePageViewModel(
    ref.watch(authServiceProvider),
    ref.watch(realtimeDatabaseServiceProvider),
  );
});

class OnlinePresencePageViewModel {
  OnlinePresencePageViewModel(this._authService, this._realtimeDatabaseService);

  final AuthService _authService;
  final RealtimeDatabaseService _realtimeDatabaseService;

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> updateUserPresence() async {
    await _realtimeDatabaseService
        .updateUserPresence(_authService.currentUserId);
  }
}
