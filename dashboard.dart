import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimonial App',
      theme: ThemeData(
        primaryColor: Colors.red[800],
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // hide debug banner
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // background color
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text(
          'Matrimonial',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // first row for cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myCard('Add User', Icons.note_alt_outlined),
                  myCard('User List', Icons.assignment_ind_outlined),
                ],
              ),
              SizedBox(height: 20),
              // second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myCard('Favourite', Icons.favorite_outline),
                  myCard('About Us', Icons.account_circle_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function to create card
  Widget myCard(String title, IconData myIcon) {
    return GestureDetector(
      onTap: () {
        print(title + ' clicked');
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              myIcon,
              size: 40.0,
              color: Colors.black,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

