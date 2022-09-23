import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdd_go/provider/provider_state.dart';
import 'package:sdd_go/screens/home.dart';
import 'package:sdd_go/screens/sign_up.dart';
import 'package:sdd_go/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// login text editing controllers
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

final _formKey = GlobalKey<FormState>();

// // login method
// _logIn(String email, String password, BuildContext context) async {
//   ProviderState _providerState =
//       Provider.of<ProviderState>(context, listen: false);
//   try {
//     if (await _providerState.logIn(email, password)) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: ((context) => const HomePage())));
//     }
//   } on FirebaseAuthException catch (e) {
// if (e.code == 'user-not-found') {
//   return await showErrorDialog(context, 'USER NOT FOUND');
// }
//   }
// }

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // column to carry, sdd logo Login and Register button
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Image(
                image: AssetImage('assets/images/sddlogo.png'),
                width: 120,
                height: 120,
              ),
            ),
            heightBox,
            // text for Login
            const Text(
              'Login',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            heightBox,
            // email field
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: TextFormField(
                controller: email,
                decoration: textformfield.copyWith(hintText: 'Email'),
              ),
            ),
            heightBox,
            // password field
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 0),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: textformfield.copyWith(hintText: 'Password'),
              ),
            ),

            heightBox,
            // login button
            ElevatedButton(
                style: raisedBtnStyle,
                onPressed: () async {
                  try {
                    if (await Provider.of<ProviderState>(context, listen: false)
                        .logIn(email.text, password.text)) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>  HomePage())));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print(e);
                    }
                    if (e.code == 'wrong-password') {
                      print(e);
                    }
                  }
                },
                child: const Text('Login')),

            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'Dont have an account ?',
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: ' SignUp',
                  style: const TextStyle(color: Colors.red, fontSize: 20.0),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                      print('login');
                    })
            ])),
          ],
        ),
      ),
    );
  }
}
