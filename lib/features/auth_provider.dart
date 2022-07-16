import 'package:firebase_auth/firebase_auth.dart';
import 'package:jumia_shop/utils/base_provider.dart';

class AuthProvider extends BaseProvider {
  FirebaseAuth get _fireAuth => FirebaseAuth.instance;

  AuthProvider() {
    test();
  }

  Future<void> test() async {
    final _result = await _fireAuth.signInWithEmailAndPassword(
      email: 'test@chima.com',
      password: 'Ruthy123',
    );
  }
}
