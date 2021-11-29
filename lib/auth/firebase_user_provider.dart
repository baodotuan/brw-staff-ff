import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BrwStaffFirebaseUser {
  BrwStaffFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

BrwStaffFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BrwStaffFirebaseUser> brwStaffFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BrwStaffFirebaseUser>(
            (user) => currentUser = BrwStaffFirebaseUser(user));
