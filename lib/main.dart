import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_app/pages/form.dart';
import 'package:form_app/pages/loading.dart';
import 'package:form_app/pages/login.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyForm()
   //  MaterialApp(
   //    debugShowCheckedModeBanner: false,
   //    initialRoute: '/',
   //    routes: {
   //      '/':(context) =>Loading(),
   //      '/login':(context) =>LoginForm(),
   //      '/home':(context)=>MyHomePage(),
   //      '/form':(context) => Forms(),
   //    },
   // )
  );
}
class MyForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),

        ),
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {

          '/':(context) =>Loading(),
          '/Auth':(context) =>AuthWrapper(),
          //'/home':(context)=>MyHomePage(),
          '/form':(context) => Forms(),
        },

      ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
const AuthWrapper({
  Key key,
}):super(key:key);

  @override
  Widget build(BuildContext context){
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null){
      return MyHomePage();
    }else{
      return LoginForm();
    }

  }
}

