import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdd_go/provider/provider_state.dart';
import 'package:sdd_go/screens/home.dart';
import 'package:sdd_go/screens/login.dart';
import 'package:sdd_go/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderState())],
    child: const  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SofaDonDo',
      home: LoginPage(),
    ),
  ));
}
