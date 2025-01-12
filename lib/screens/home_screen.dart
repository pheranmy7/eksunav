import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false; // For theme toggling

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You have been logged out.")),
    );
  }

  void showOptionDetails(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(user?.displayName ?? "Guest User"),
                  accountEmail: Text(user?.email ?? "Not Signed In"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text("Favorites"),
                  onTap: () => showOptionDetails(context, "Favorites",
                      "Save frequently visited locations for quick access."),
                ),
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text("Recap/Analytics"),
                  onTap: () => showOptionDetails(context, "Recap/Analytics",
                      "Insights into visited locations, such as 'Most Visited Locations'."),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notification Settings"),
                  onTap: () => showOptionDetails(
                      context,
                      "Notification Settings",
                      "Manage app notifications and preferences."),
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text("Help & Support"),
                  onTap: () => showOptionDetails(context, "Help & Support",
                      "Access FAQs, contact support, or view 'How to Use' guides."),
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text("Feedback"),
                  onTap: () => showOptionDetails(context, "Feedback",
                      "Provide feedback on the app or report issues."),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About the App"),
                  onTap: () => showOptionDetails(context, "About the App",
                      "View app version, developer details, and privacy policy."),
                ),
                ListTile(
                  leading: const Icon(Icons.newspaper),
                  title: const Text("Campus News & Updates"),
                  onTap: () => showOptionDetails(
                      context,
                      "Campus News & Updates",
                      "Latest news and updates relevant to the campus."),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("Emergency Contact"),
                  onTap: () => showOptionDetails(context, "Emergency Contact",
                      "Quick access to emergency numbers or campus safety."),
                ),
                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: const Text("Theme"),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: const Icon(Icons.menu, size: 30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  "Account Options",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/auth');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: user != null
                                          ? () async {
                                              Navigator.pop(context);
                                              await signOut(context);
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        backgroundColor: user != null
                                            ? Colors.red
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Log Out",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(Icons.person, size: 30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // "Recent Search" section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Recent Search",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Recently you searched about best restaurants near you.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),

                // Weather information box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "25°C",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "7th January 2025",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  "Ekiti State University, Ado-Ekiti",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.cloud, size: 40, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Category Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Cards for categories in a grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 2, // Two cards per row
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryCard(
                        title: "Restaurants",
                        subtitle: "9 locations",
                        imageUrl: "assets/images/restaurants.jpg",
                      ),
                      _buildCategoryCard(
                        title: "Banks",
                        subtitle: "7 locations",
                        imageUrl: "assets/images/bank.jpg",
                      ),
                      _buildCategoryCard(
                        title: "Libraries",
                        subtitle: "1 location",
                        imageUrl: "assets/images/library.jpg",
                      ),
                      _buildCategoryCard(
                        title: "Cybercafes",
                        subtitle: "40 locations",
                        imageUrl: "assets/images/cafe.jpg",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recents Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Recents",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                _buildRecentItem("Restaurants", "Rite Meal Restaurant", "700m"),
                const SizedBox(height: 16),
                _buildRecentItem("Banks", "Gtbank", "400m"),
                const SizedBox(height: 16),
                _buildRecentItem("Libraries", "Main Campus Library", "900m"),
                const SizedBox(height: 16),
                _buildRecentItem("Cybercafes", "Horla Cafe", "60m"),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0, // Index for Home tab
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(
                      context, '/home'); // Navigate to Home
                  break;
                case 1:
                  Navigator.pushReplacementNamed(
                      context, '/location'); // Navigate to Location
                  break;
                case 2:
                  Navigator.pushReplacementNamed(
                      context, '/profile'); // Navigate to Profile
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: 'Location'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }

  Widget _buildCategoryCard(
      {required String title,
      required String subtitle,
      required String imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentItem(String category, String name, String distance) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(Icons.location_on, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
