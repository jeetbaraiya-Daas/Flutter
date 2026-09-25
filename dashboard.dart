import 'package:flutter/material.dart';
import 'package:matrimony/registration_screen.dart';
import 'package:matrimony/user_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              // First row: Add User & User List
              Row(
                children: [
                  buildMenuCard(
                    label: "Add User",
                    iconPath: "assets/image/registration.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    label: "User List",
                    iconPath: "assets/image/customer.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserList(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // Second row: Favorite & About Us
              Row(
                children: [
                  buildMenuCard(
                    label: "Favorite",
                    iconPath: "assets/image/heart.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserList(fromFav: true),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    label: "About Us",
                    iconPath: "assets/image/profile.png",
                    onTap: () {
                      // TODO: add about us screen if needed
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable card for 4 buttons 
  Widget buildMenuCard({
    required String iconPath,
    required String label,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        height: 155,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  height: 68,
                  width: 68,
                  color: Colors.pink.shade700,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
