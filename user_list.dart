import 'package:flutter/material.dart';
import 'package:matrimony/dbHelper.dart';
import 'package:matrimony/registration_screen.dart';
import 'package:matrimony/user.dart';

class UserList extends StatefulWidget {
  bool fromFav;

  UserList({super.key, this.fromFav = false});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final DBHelper db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fromFav ? "Favorite Users" : "User List"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: FutureBuilder<List<User>>(
        // Check if opened from Favorite button or User List button
        future: widget.fromFav ? db.getAllFavouriteUser() : db.getAllUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> profileList = snapshot.data!;

            return ListView.builder(
              itemCount: profileList.length,
              itemBuilder: (context, index) {
                User item = profileList[index];

                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      // Left side: user details
                      Expanded(
                        child: Column(
                          children: [
                            buildDetailRow(
                              iconData: Icons.person,
                              value: "${item.FirstName} ${item.LastName}",
                            ),
                            buildDetailRow(
                              iconData: Icons.location_city,
                              value: item.City,
                            ),
                            buildDetailRow(
                              iconData: Icons.phone,
                              value: item.Mobile,
                            ),
                            buildDetailRow(
                              iconData: Icons.mail,
                              value: item.Email,
                            ),
                          ],
                        ),
                      ),
                      //  fav, edit, and delete
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await db.setFavourite(
                                item.UserID,
                                !item.isFavourite,
                              );
                              setState(() {});
                            },
                            icon: Icon(
                              item.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.pink.shade700,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationScreen(
                                    user: item,
                                  ),
                                ),
                              ).then((val) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              await db.deleteUser(item.UserID);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Data Found"),
            );
          }
        },
      ),
    );
  }

  // display icon
  Widget buildDetailRow({required IconData iconData, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(iconData, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
