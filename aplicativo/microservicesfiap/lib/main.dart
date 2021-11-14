import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:microservicesfiap/screens/all_credit_cards.dart';
import 'package:microservicesfiap/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', '')],
      initialRoute: '/',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => HomePage(),
        '/histcartoes': (context) => AllCreditCards(),
      },
    );
  }
}
