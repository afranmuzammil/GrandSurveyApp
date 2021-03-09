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










// class GsForm extends StatefulWidget {
//   @override
//   _GsFormState createState() => _GsFormState();
// }
//
// class _GsFormState extends State<GsForm> {
//   final formkey = GlobalKey<FormState>();
//
//   var userId ;
//   var passWord;
//   var realId ="afran";
//   var realPass = "1234";
//
//   final idCon = new TextEditingController();
//   final passCon = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: idCon,
//                 decoration: InputDecoration(
//                   //border: InputBorder.none,
//                   hintText: 'ENTER YOUR ID',
//                 ),
//                 validator: (value){
//                   if(value.isEmpty){
//                     return  'Please enter the Id u where provided';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: passCon,
//                 decoration: InputDecoration(
//                  // border: InputBorder.none,
//                   hintText: 'ENTER THE PASSWORD',
//                 ),
//                 validator: (value){
//                   if(value.isEmpty){
//                     return  'Please enter the Id u where provided';
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
//                 ),
//                   onPressed: (){
//                     if(formkey.currentState.validate()){
//                       Scaffold
//                           .of(context)
//                           .showSnackBar(SnackBar(content:Text("Processing data")));
//                       setState(() {
//                         if(userId ==realId && passWord == realPass){
//                           Scaffold
//                               .of(context)
//                               .showSnackBar(SnackBar(content:Text("You have login")));
//                         }
//                         else{
//                           Scaffold
//                               .of(context)
//                               .showSnackBar(SnackBar(content:Text("Incorrect loinId or password")));
//                         }
//                         /*userId = idCon.text;
//                         passWord = passCon.text;*/
//                       });
//                     }
//                   },
//
//                   child: Text("LogIn"),
//               ),
//               Text("your id is $userId  and password is $passWord")
//             ],
//           ),
//         )
//     );
//   }
// }
