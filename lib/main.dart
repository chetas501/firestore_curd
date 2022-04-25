import 'package:flutter/material.dart';
import 'package:flutter_curd/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
}

// Variant: debug
// Config: debug
// Store: C:\Users\ChetasShree\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: F9:FB:3B:A3:AB:51:33:E2:16:B6:FD:C6:22:7A:35:D0
// SHA1: E0:30:56:BA:CA:75:42:43:17:09:B1:81:9E:C9:EC:FC:15:5F:87:A0
// SHA-256: 30:87:2F:56:C3:B6:2E:C3:59:AE:3F:20:93:7E:72:BC:24:A6:FC:92:C7:8B:ED:23:5B:2F:CC:7E:1D:BB:5B:0B
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter FireStore CURD',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
