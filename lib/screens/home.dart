import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdd_go/provider/provider_state.dart';
import 'package:sdd_go/theme/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    // call the provider state to acess the name of the logged in user
    ProviderState provider = Provider.of<ProviderState>(context);

    
    

    var userName = provider.users.doc().id ;
     

    return Scaffold(
      body: 
         SafeArea(
            child: Column(
          children:   [
            Text('Welcome User!'),
             heightBox,
             
          ],
        )),
      
    );
  }
}
