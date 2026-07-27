import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact deep red sampled from the image
    const Color appRed = Color(0xFFC62828);

    return MaterialApp(
      title: 'Matrimonial App',
      theme: ThemeData(
        // Set up theme colors
        primaryColor: appRed,
        colorScheme: ColorScheme.fromSeed(seedColor: appRed),
        useMaterial3: true,
      ),
      home: const MatrimonialStandardHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MatrimonialStandardHomePage extends StatelessWidget {
  const MatrimonialStandardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color appRed = Color(0xFFC62828);
    const Color bodyGrey = Color(0xFFF5F5F5); // Light grey/off-white body

    return Scaffold(
      backgroundColor: bodyGrey,
      appBar: AppBar(
        // Set standard appbar height
        toolbarHeight: 64.0,
        backgroundColor: appRed,
        automaticallyImplyLeading: false, // Ensure no default back button
        // Left-aligned title with correct styling
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Matrimonial',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        // Handle standard status bar styling (will have dynamic phone clock/carrier)
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Or appRed to match
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      // Replaced GridView with a manual Column and Row layout
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
          child: Column(
            children: [
              // First Row
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0, // Keeps the card square
                      child: _buildDashboardCard(
                        icon: Icons.note_alt_outlined,
                        text: 'Add User',
                        onTap: () {
                          debugPrint('Add User tapped');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0), // Horizontal spacing
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: _buildDashboardCard(
                        icon: Icons.assignment_ind_outlined,
                        text: 'User List',
                        onTap: () {
                          debugPrint('User List tapped');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 25.0), // Vertical spacing between rows
              
              // Second Row
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: _buildDashboardCard(
                        icon: Icons.favorite_outline,
                        text: 'Favourite',
                        onTap: () {
                          debugPrint('Favourite tapped');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0), // Horizontal spacing
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: _buildDashboardCard(
                        icon: Icons.account_circle_outlined,
                        text: 'About Us',
                        onTap: () {
                          debugPrint('About Us tapped');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable card component remains exactly the same
  Widget _buildDashboardCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      elevation: 8.0,
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 44.0, // Match visual size from image
            ),
            const SizedBox(height: 12.0),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
