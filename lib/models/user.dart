import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  MyUser({required this.email});

  static FirebaseAuth _auth = FirebaseAuth.instance;
  String email;

//  static Future<MyUser> signIn(String email, String password) async {
//     MyUser user = null;
//     try {
//       UserCredential cred = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       String myEmail = cred.user!.email!;
//       String myPassword = cred.user.;
//       isSuccess = true;
//     } catch (e) {
//       print(e.toString());
//     }
//     return isSuccess;
//   }
}
