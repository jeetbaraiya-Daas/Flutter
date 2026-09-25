import 'package:matrimony/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // database and create table
  Future<Database> initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, "matrimony_db.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE User ("
          "UserID INTEGER PRIMARY KEY AUTOINCREMENT, "
          "FirstName VARCHAR(500), "
          "LastName VARCHAR(500), "
          "Email VARCHAR(500), "
          "Mobile VARCHAR(200), "
          "DOB VARCHAR(200), "
          "City VARCHAR(100), "
          "Gender VARCHAR(50), "
          "Hobbies VARCHAR(100), "
          "Password VARCHAR(200), "
          "isFavourite BOOLEAN)",
        );
      },
    );
  }

  // Insert new record
  Future<int> insertUser(User user) async {
    Database db = await initDatabase();
    return await db.insert("User", user.toMap());
  }

  // Update user details
  Future<int> updateUser(User user) async {
    Database db = await initDatabase();
    return await db.update(
      "User",
      user.toMap(),
      where: "UserID = ?",
      whereArgs: [user.UserID],
    );
  }

  // Fetch all users from database
  Future<List<User>> getAllUser() async {
    List<User> list = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> result = await db.query("User");

    for (var row in result) {
      User u = User();
      u.UserID = int.parse(row["UserID"].toString());
      u.FirstName = row["FirstName"].toString();
      u.LastName = row["LastName"].toString();
      u.Email = row["Email"].toString();
      u.Mobile = row["Mobile"].toString();
      u.DOB = row["DOB"].toString();
      u.City = row["City"].toString();
      u.Gender = row["Gender"].toString();
      u.Hobbies = row["Hobbies"].toString();
      u.Password = row["Password"].toString();
      u.isFavourite = row["isFavourite"].toString() == "1";
      list.add(u);
    }
    return list;
  }

  // Fetch only favorite users
  Future<List<User>> getAllFavouriteUser() async {
    List<User> favList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> result = await db.query(
      "User",
      where: "isFavourite = ?",
      whereArgs: ["1"],
    );

    for (var row in result) {
      User u = User();
      u.UserID = int.parse(row["UserID"].toString());
      u.FirstName = row["FirstName"].toString();
      u.LastName = row["LastName"].toString();
      u.Email = row["Email"].toString();
      u.Mobile = row["Mobile"].toString();
      u.DOB = row["DOB"].toString();
      u.City = row["City"].toString();
      u.Gender = row["Gender"].toString();
      u.Hobbies = row["Hobbies"].toString();
      u.Password = row["Password"].toString();
      u.isFavourite = row["isFavourite"].toString() == "1";
      favList.add(u);
    }
    return favList;
  }

  // favorite status for a user
  Future<void> setFavourite(int userID, bool isFav) async {
    Database db = await initDatabase();
    await db.execute(
      "UPDATE User SET isFavourite = ? WHERE UserID = ?",
      [isFav, userID],
    );
  }

  // Delete user by ID
  Future<void> deleteUser(int userID) async {
    Database db = await initDatabase();
    await db.delete(
      "User",
      where: "UserID = ?",
      whereArgs: [userID],
    );
  }
}
