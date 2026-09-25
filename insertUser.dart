import 'package:flutter/material.dart';
import 'package:matrimony/dbHelper.dart';
import 'package:matrimony/user.dart';

class Insertuser extends StatefulWidget {
  const Insertuser({super.key});

  @override
  State<Insertuser> createState() => _InsertuserState();
}

class _InsertuserState extends State<Insertuser> {
  int insertedId = 0;
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Dummy user data for testing database insert
                User tempUser = User();
                tempUser.FirstName = "Aarav";
                tempUser.LastName = "Patel";
                tempUser.Email = "aarav@gmail.com";
                tempUser.Mobile = "9876543210";
                tempUser.Password = "123456";
                tempUser.Hobbies = "Reading";
                tempUser.Gender = "Male";
                tempUser.City = "Ahmedabad";
                tempUser.DOB = DateTime.now().toIso8601String();

                int id = await dbHelper.insertUser(tempUser);
                setState(() {
                  insertedId = id;
                });
              },
              child: const Text("Insert User"),
            ),
            const SizedBox(height: 10),
            Text("Inserted ID: $insertedId"),
          ],
        ),
      ),
    );
  }
}
