import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial2/global/common/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
    final auth = FirebaseAuth.instance;

    Future<User?> signUp(String email, String password) async {
        try {
            UserCredential credential =
            await auth.createUserWithEmailAndPassword(
                email: email,
                password: password);
            return credential.user;
        }
        on FirebaseAuthException catch (e) {
            if (e.code == 'email-already-in-use') {
                Fluttertoast.showToast(msg: 'User not found'
                );
                print('User not found');
            }
            else {
                Fluttertoast.showToast(msg: 'Error: $e.code'
                );
                print('Error: $e.code');
            }
        }
    }

    Future<User?> login(String email, String password) async {
        try {
            UserCredential credential =
            await auth.signInWithEmailAndPassword(
                email: email,
                password: password);
            return credential.user;
        }
        on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found' ||
                e.code == 'wrong-password'
            ) {
                Fluttertoast.showToast(msg: 'Wrong email or password');
                print('Wrong email or password');
            }
            else {
                Fluttertoast.showToast(msg: 'Error: $e.code');
                print('Error: $e.code');
            }
        }
    }
}