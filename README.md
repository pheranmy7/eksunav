# eksunav

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

EksuNav: Campus Navigation Application for Ekiti State University
Project Overview
EksuNav is a mobile-based campus navigation application designed for Ekiti State University (EKSU). It aims to address the challenges students, staff, and visitors face in navigating the vast and complex university campus. EksuNav provides real-time navigation, category-based search, and user-friendly features to enhance the campus experience.

Features
Real-Time Navigation: Easily find and navigate to locations on campus using an interactive map.
Category-Based Search: Search for specific locations (e.g., restaurants, libraries, banks) based on predefined categories.
Profile Updates: Access a personalized profile with user ID, current location, and history of visited locations.
Dark Mode and Light Mode: Switch between light and dark themes for a comfortable user experience.
Recap/Analytics: Track frequently visited locations for personalized insights.
Authentication: Secure sign-in using Google authentication services.
User-Friendly Sidebar: Navigate features like emergency contacts, campus news, feedback, and app settings with ease.
Requirements
To run EksuNav, you need the following:

Flutter Framework (Version 3.10.0 or higher).
Dart SDK (Compatible with the Flutter version).
Android Studio or Visual Studio Code with Flutter plugin installed.
Mapbox API Key for map functionalities (optional during initial setup).
Firebase Project Configuration for authentication.

Installation and Setup
Follow these steps to set up the EksuNav application:

Clone the Repository
git clone <repository-link>
cd eksunav

Install Dependencies
flutter pub get

Add Mapbox API Key
Obtain an API key from the your Mapbox account.
Add the API key to the AndroidManifest.xml file under the <meta-data> tag for maps functionality.

Firebase Configuration
Download the google-services.json file for Android from your Firebase project.
Place it in the android/app/ directory.
Ensure that Firebase Authentication is enabled in the Firebase console.
Run the App
To test the app on an emulator or physical device, use the following command:
flutter run

Testing Instructions
The project includes widget tests for all screens. Here's an overview of the testing process:
Set Up Testing Environment: The flutter_test package is integrated into the project.
Test Cases: Test files for each screen (e.g., home_screen_test.dart) validate the widgets and behaviors of the app.
Run Tests: Use the Flutter command to execute tests locally:
flutter test
Edge Cases: Tests cover scenarios such as empty data, slow connections, and failed sign-ins.

App Navigation Guide
Home Screen:
View the campus map, recent searches, and weather updates.
Use the bottom navigation bar to switch between Home, Location, and Profile screens.

Location Screen:
Explore the interactive map for real-time navigation.
View markers for nearby places based on categories like restaurants or libraries.

Profile Screen:
View your ID, current location, and visit history.
Access personalized information securely.
Sidebar Features:

Access Recap/Analytics, Notification Settings, Help & Support, Emergency Contacts, and Theme options.
Recommendations for Future Improvements
Offline Mode: Incorporate offline navigation for areas with limited network access.
Expanded Analytics: Provide additional insights, such as user movement patterns and heat maps.
Chat Functionality: Enable real-time chat for users to share locations and coordinate on campus.
Project Conclusion
EksuNav simplifies campus navigation, making it easier for students, staff, and visitors to explore Ekiti State University. By integrating real-time maps, authentication, and user-friendly interfaces, it enhances the overall campus experience.

The app's modular design ensures adaptability for future enhancements and features. EksuNav sets a foundation for innovative solutions to campus navigation challenges.

Contact and Support
For inquiries or support, contact:

Developer: Oluwaferanmi Olabiyi
Email: pheranmyolabiyi@gmail.com