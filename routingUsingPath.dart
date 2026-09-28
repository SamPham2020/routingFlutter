import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', 
      routes: {
        '/': (context) => FirstScreen(), 
        '/second': (context) => SecondScreen(), 
      }
    );
  }
}

class FirstScreen extends StatelessWidget {
  // const new({super.key});
  final List<String> items = ['pc', 'Mac', 'Mew']; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),

      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              // Navigator.pushNamed(context, '/second', arguments: 'Send some Data');
              Navigator.pushNamed(context, '/second', arguments: items);
            }, child: Text('Go to the second screen')), 
          ],
        ),
      )
    ); 
  }
}

class SecondScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // we have to call modalroute setting as this is the convention
    // ModalRoute.of(context)? because object can be null 
    // final String? data = ModalRoute.of(context)?.settings.arguments as String; 
    // nullable operators if no data then make it an empty container/list
    //?? [] has to be explicity stated here to give tge compiler not to assume 
    /// the value but the developer enforce that value could be a null list  
    // sometimes we request data from API which can be null so we want use nullable variable to avoid crash
    final List<String> dataItems = ModalRoute.of(context)?.settings.arguments as List<String>? ?? []; 
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'), 
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Text('Data from First: $data')
      //       // Text('Data from First: $dataItems')
      //     ],
      //   ),
      // ),
      body: ListView.builder( 
        itemCount: dataItems.length, 
        itemBuilder: (context, index) {
            return ListTile(title: Text(dataItems[index])); 
          },
        ),
    ); 
  }
}
