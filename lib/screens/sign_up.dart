import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdd_go/provider/provider_state.dart';
import 'package:sdd_go/screens/login.dart';
import 'package:sdd_go/theme/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // declare password visible variable
  bool _passwordVisible = false;
// initialize obscurirty for password field
  @override
  void initState() {
    _passwordVisible = false;
  }

// create variable for form key
  final _formKey = GlobalKey<FormState>();

  // create text editing fields
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // signup method to check if user credentials is present
  // if user has signed up sucesssfully, push user to login page
  void addUser() async {
    FirebaseAuth.instance;
    FirebaseFirestore.instance;

    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);

    try {
      await _providerState.addUserToDatabase(
        firstname: firstName.text,
        lastname: lastName.text,
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void _signUp(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.signUp(email, password)) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const LoginPage())));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // set background Color to white
      color: Colors.white,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                //  logo image for sofadondo
                const Image(
                  image: AssetImage('assets/images/sddlogo.png'),
                  width: 120.0,
                  height: 120.0,
                ),
                heightBox,
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                heightBox,
                // sing up form
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //  textfield for first name
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            // check if the first name field is validated
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            }),
                            controller: firstName,
                            decoration:
                                textformfield.copyWith(labelText: 'First Name'),
                            cursorColor: Colors.red,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        heightBox,

                        // last name  textfield
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            // check if last name field is empty
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            }),
                            controller: lastName,
                            decoration: textformfield.copyWith(
                                hintText: 'Last Name ', labelText: 'Last Name'),
                            cursorColor: Colors.red,
                          ),
                        ),
                        heightBox,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Email';
                              }
                              // use reg expression to crosscheck the email is properly formatted
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            controller: email,
                            decoration: textformfield.copyWith(
                                hintText: 'Email', labelText: 'Email Address'),
                            cursorColor: Colors.red,
                          ),
                        ),
                        heightBox,

                        // password field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please create a password';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            controller: password,
                            decoration: textformfield.copyWith(
                                hintText: 'Enter Password',
                                labelText: ' Create Password',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.red,
                                    ))),
                            cursorColor: Colors.red,
                            obscureText: _passwordVisible,
                          ),
                        ),
                        heightBox,
                        // confirm password
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm password field is empty";
                              }
                              if (confirmPassword.text != password.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            controller: confirmPassword,
                            decoration: textformfield.copyWith(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(_passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: Colors.red,
                                )),
                            cursorColor: Colors.red,
                            obscureText: _passwordVisible,
                          ),
                        ),

                        heightBox,
                        ElevatedButton(
                            style: raisedBtnStyle,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  _signUp(email.text, password.text, context);
                                  addUser();
                                  print('registration complete');
                                } on FirebaseAuthException catch (e) {}
                              }
                            },
                            child: const Text('Register')),
                      ],
                    )),

                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: 'Already have an account ?',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: ' Login',
                      style: const TextStyle(color: Colors.red, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          print('login');
                        })
                ])),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
