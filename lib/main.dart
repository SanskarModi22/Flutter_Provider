import 'package:flutter/material.dart';
import 'package:flutter_provider/api/prov_api.dart';
import 'package:flutter_provider/controllers/notifier.dart';
import 'package:flutter_provider/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        //Using Multiproviders we can add multiple providers
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserNot(),
          ),
          FutureProvider(create:(_)=> getProfileUserName(), initialData: "Loading Data ..."),
          StreamProvider(create: (_)=>getSessionTime(), initialData:0)
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFF2F5233)),
        primaryColor: Color(0xFF2F5233),
        backgroundColor: Color(0xFFDCDCDC),
      ),
      home: Home(),
    );
  }
}
