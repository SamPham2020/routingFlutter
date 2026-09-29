import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 initialRoute: '/',
 routes: {
 '/': (context) => FirstScreen(),
 '/second': (context) => SecondScreen(),
 '/third': (context) => ThirdScreen(),
 },
 );
 }
}

class FirstScreen extends StatelessWidget {
 final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('First Screen'),
 ),
 body: Center(
 child: ElevatedButton(
 onPressed: () {
 Navigator.pushNamed(
 context,
 '/second',
 arguments: items,
 );
 },
 child: Text('Go to Second Screen'),
 ),
 ),
 );
 }
}

class SecondScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 final List<String> items =
 ModalRoute.of(context)?.settings.arguments as List<String>? ?? [];

 return Scaffold(
 appBar: AppBar(
 title: Text('Second Screen'),
 ),
 body: Center(
 child: ElevatedButton(
 onPressed: () {
 Navigator.pushNamed(
 context,
 '/third',
 );
 },
 child: Text('Go to Third Screen'),
 ),
 ),
 );
 }
}

class ThirdScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('Third Screen'),
 ),
 body: Center(
 child: ElevatedButton(
 onPressed: () {
 Navigator.pushNamedAndRemoveUntil(
 context,
 '/',
 (route) => false,
 );
 },
 child: Text('Return to First Screen'),
 ),
 ),
 );
 }
}
