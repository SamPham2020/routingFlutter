import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Lab task) To create and implement a hotel application, you need to design four
// screens, each with specific instructions. Screen 1: This screen enables users to
// create their account credentials. Upon clicking the button, the app should navigate
// to the second screen while displaying the user's entered name on subsequent
// screens.
// Screen 2: After logging in, users will access the home screen. Here, they can view
// images of hotels along with a button for accessing additional information. The text
// 'User' at the top should dynamically display the name provided during the account
// process on the previous page.
// Screen 3: Users can access this page by tapping the button on the previous screen.
// Here, they can input their details and proceed to book, as depicted below
// Screen 4: After completing the booking process, the app will calculate the price and
// present the relevant information. Additionally, there will be a button at the top of
// the screen to return to the home (Screen 2).
void main() => runApp(HotelBookingApp());

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking app',
      // home: LoggingScreen(),
      // home: HotelListScreen(),
      // home: HotelDetailScreen(),
      // home: HotelBookingConfirmationScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoggingScreen(),
        '/hotelList': (context) => HotelListScreen(),
        '/detailHotel': (context) => HotelDetailScreen(),
        '/bookingConfirmation': (context) => HotelBookingConfirmationScreen(),
      },
    );
  }
}
class HotelBookingConfirmationScreen extends StatelessWidget {
  const HotelBookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String?> dataItems = ModalRoute.of(context)?.settings.arguments as List<String?>? ?? [];
    String? username = dataItems.isNotEmpty ? dataItems[0] : 'Guest';
    String? totalPrice = dataItems.isNotEmpty ? dataItems[1] : '0';
    return  Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
          child:Container(
           padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text('Home')
                    ),

                    Text('$username'),
                  ],
                ),

                Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  child: Text('Thanks for Booking', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),

                ElevatedButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('You have pressed pay \$$totalPrice'),
                      ),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text('Please pay $totalPrice'),
                ),
              ],
            ),

          )

      ),
    );
  }
}

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final String? username = ModalRoute.of(context)?.settings.arguments as String?;
    // List<String?> dataItemsPrev = ModalRoute.of(context)?.settings.arguments as List<String?>? ?? [];
    // String? username = dataItemsPrev.isNotEmpty ? dataItemsPrev[0] : 'Guest';
    // 1. Grab the raw argument object dynamically
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;

    // 2. Safe defensive checks matching confirmation screen pattern
    late String username, imageidx;
    if (arguments is List && arguments.isNotEmpty) {
      // If it arrives as a list, safely extract the first slot
      username = arguments.first?.toString() ?? 'Guest';
    } else if (arguments is String) {
      // If it arrives as a plain string, use it directly
      username = arguments;
    }

    if (arguments is List && arguments.isNotEmpty) {
      // If it arrives as a list, safely extract the first slot
      imageidx = arguments.last?.toString() ?? '0';
    } else if (arguments is String) {
      // If it arrives as a plain string, use it directly
      imageidx = arguments;
    }
    final double price = 100;
    List<String?> dataItems = [username];

    final TextEditingController numNightController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text('$username'),
                ),
                Center(

                  child: Column(
                    children: [
                      Text('Details and Booking',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      Image.asset('assets/animal$imageidx.jpg'),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsetsGeometry.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text('$price Cad Per Night', style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter the no of Customer',
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextField(
                              controller: numNightController,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                labelText: 'Enter the no of Nights',
                              ),
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton(onPressed: ()
                              {
                                // keyboardType: TextInputType.number;
                                int inputNumNights = int.tryParse(numNightController.text) ?? 0;
                                double totalPrice = inputNumNights * price;
                                if (inputNumNights > 0) {
                                  dataItems.add('$totalPrice');

                                  Navigator.pushNamed(
                                      context, '/bookingConfirmation',
                                      arguments: dataItems);
                                }else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('no Nights cannot be 0')));
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(16),
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.maxFinite, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(2),
                                )
                              ),
                              child: (Text('Book Now')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
      ),
    );
  }
}


class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {

  late List<String?> dataItems = [];
  @override
  Widget build(BuildContext context) {
    final String? username = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text('$username'),
            ),

            Align(
              alignment: Alignment.center,
              child: Text('List of Hotel',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(color: Colors.black12,),
            _buildHotelTile(1, username),
            _buildHotelTile(2, username),
            _buildHotelTile(3, username),
            _buildHotelTile(4, username),
          ],
        ),
      ),
    );
  }

  // pic on left, and button click info on the right
  Widget _buildHotelTile(int imageNum, String? username) {
    return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 140,
              width: 120,
              child: Image.asset('assets/animal$imageNum.jpg',),
            ),

            Expanded(
                child: Padding (
                  padding: EdgeInsetsGeometry.fromLTRB(30, 0, 30, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      dataItems.add(username);
                      dataItems.add('$imageNum');
                      Navigator.pushNamed(context ,'/detailHotel', arguments: dataItems);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('Click For Info',)
                ),
                ),
            ),
          ],
      ),
    );
  }

}

class LoggingScreen extends StatefulWidget {
  const LoggingScreen({super.key});

  @override
  State<LoggingScreen> createState() => _LoggingScreenState();
}

class _LoggingScreenState extends State<LoggingScreen> {
  final TextEditingController _nameController = TextEditingController();
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue,
      ),
      body : Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 20, 0, 40),
              child: Image.asset('assets/animal0.jpg'),
            ),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                labelText: 'Name',
                // hintText: 'Name',
              ),
            ),
            SizedBox(height: 20,),

            TextField(
             decoration: InputDecoration(
               prefixIcon: Icon(Icons.mail, color: Colors.grey,),
               labelText: 'Email',
             ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.grey,),
                labelText: 'Password',
              ),
              obscureText: true,
            ),

            SizedBox(height: 60,),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String inp = _nameController.text.trim();
                  _name = inp.isEmpty ? 'Guest' : inp;
                });
                Navigator.pushNamed(context, '/hotelList', arguments: _name);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )
              ),
              child: Text('Create Account', style: TextStyle(
                color: Colors.white,
              ),)
            ),
          ],
        ),
      ),
    );
  }
}



