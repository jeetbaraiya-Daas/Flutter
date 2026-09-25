import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/dbHelper.dart';
import 'package:matrimony/user.dart';

class RegistrationScreen extends StatefulWidget {
  User? user;

  RegistrationScreen({super.key, this.user});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Text controllers for form inputs
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String selectedGender = "Male";
  List<String> userHobbies = [];
  List<String> hobbyOptions = ["Reading", "Sports", "Music", "Travel"];

  DateTime birthDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadUserData();
    dobCtrl.text = DateFormat("dd/MM/yyyy").format(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? "Registration Form" : "Edit Profile",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildInputField(
            controller: firstNameCtrl,
            label: "Enter First Name",
            inputType: TextInputType.name,
          ),
          buildInputField(
            controller: lastNameCtrl,
            label: "Enter Last Name",
            inputType: TextInputType.name,
          ),
          buildInputField(
            controller: emailCtrl,
            label: "Enter Email",
            inputType: TextInputType.emailAddress,
          ),
          buildInputField(
            controller: mobileCtrl,
            label: "Enter Mobile",
            inputType: TextInputType.number,
          ),
          buildInputField(
            controller: cityCtrl,
            label: "Enter City",
            inputType: TextInputType.name,
          ),

          // Date of Birth picker field
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              readOnly: true,
              controller: dobCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Select Date of Birth",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: birthDate,
                  firstDate: DateTime(1925),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  birthDate = picked;
                  dobCtrl.text = DateFormat("dd/MM/yyyy").format(birthDate);
                  setState(() {});
                }
              },
            ),
          ),

          buildInputField(
            controller: passCtrl,
            label: "Enter Password",
            isObscure: true,
          ),

          const SizedBox(height: 8),

          // Gender Radio Buttons
          const Text(
            "Select Gender",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile(
            title: const Text("Male"),
            secondary: const Icon(Icons.male),
            value: "Male",
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value!;
              });
            },
          ),
          RadioListTile(
            title: const Text("Female"),
            secondary: const Icon(Icons.female),
            value: "Female",
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value!;
              });
            },
          ),

          // Hobbies Checkboxes
          const Text(
            "Hobbies:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: hobbyOptions
                .map(
                  (item) => CheckboxListTile(
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: userHobbies.contains(item),
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked!) {
                          userHobbies.add(item);
                        } else {
                          userHobbies.remove(item);
                        }
                      });
                    },
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 10),

          // Submit and Clear Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  saveUser();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink.shade700,
                ),
                child: Text(widget.user == null ? "Submit" : "Update"),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {
                  clearForm();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade700,
                ),
                child: const Text("Clear"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //  reusable TextFormField widget
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    bool isObscure = false,
    TextInputType? inputType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  // reset all form fields
  void clearForm() {
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    emailCtrl.clear();
    mobileCtrl.clear();
    cityCtrl.clear();
    passCtrl.clear();
    birthDate = DateTime.now();
    dobCtrl.text = DateFormat("dd/MM/yyyy").format(birthDate);
    selectedGender = "Male";
    userHobbies.clear();
  }

  // fill fields when editing an existing user
  void loadUserData() {
    if (widget.user != null) {
      firstNameCtrl.text = widget.user!.FirstName;
      lastNameCtrl.text = widget.user!.LastName;
      emailCtrl.text = widget.user!.Email;
      mobileCtrl.text = widget.user!.Mobile;
      cityCtrl.text = widget.user!.City;
      passCtrl.text = widget.user!.Password;
      userHobbies = List<String>.from(jsonDecode(widget.user!.Hobbies));
      birthDate = DateTime.parse(widget.user!.DOB);
      selectedGender = widget.user!.Gender;
    }
  }

  // insert new user or update  user in SQLite
  Future<void> saveUser() async {
    DBHelper db = DBHelper();
    User u = User();

    u.FirstName = firstNameCtrl.text;
    u.LastName = lastNameCtrl.text;
    u.Email = emailCtrl.text;
    u.Mobile = mobileCtrl.text;
    u.City = cityCtrl.text;
    u.Password = passCtrl.text;
    u.Gender = selectedGender;
    u.Hobbies = jsonEncode(userHobbies);
    u.DOB = birthDate.toIso8601String();

    if (widget.user == null) {
      int id = await db.insertUser(u);
      if (id != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User added successfully")),
        );
        clearForm();
        setState(() {});
      }
    } else {
      u.UserID = widget.user!.UserID;
      u.isFavourite = widget.user!.isFavourite;
      int rows = await db.updateUser(u);
      if (rows != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User updated successfully")),
        );
        clearForm();
        Navigator.pop(context);
      }
    }
  }
}
