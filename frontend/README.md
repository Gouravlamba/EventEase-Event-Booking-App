EventEase - Event Booking App

EventEase is a cross-platform mobile application built with Flutter & Dart, allowing users to explore, book, and manage events. It provides an intuitive and modern interface, with multiple user-friendly features for seamless event management.

#Table of Contents

#Features

#App Structure

#Screens & Sections

#Models

#State Management

#Assets

#Installation & Setup

#Run Commands

#Dependencies

#Future Enhancements

#Features

User-friendly Event Listing: Explore events with images, title, location, and available seats.

Event Booking: Quickly book tickets for your favorite events.

Home Screen Carousel: Automatically scrolling horizontal event cards with page indicators.

Profile Management: Users can view their profile and logout.

Drawer Menu: Easy navigation to Home, My Bookings, Settings, and Logout.

Notification Icon: Quick access to alerts (currently mocked).

Modern UI: Rounded cards, curved headers, and gradient overlays.

Responsive Layout: Works on different screen sizes.

App Structure
lib/
├── data/
│   └── models/
│       └── event_model.dart
├── presentation/
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── events/
│   │   │   └── event_detail_screen.dart
│   │   └── profile/
│   │       └── profile_screen.dart
│   └── widgets/
│       ├── home_event_card.dart
│       └── event_card.dart
├── state_management/
│   ├── providers/
│   │   ├── booking_provider.dart
│   │   └── auth_provider.dart
├── main.dart
└── theme/
    └── app_theme.dart

Screens & Sections
1. Home Screen

Carousel showing all events horizontally with auto-scroll.

Rounded white card container with gradient overlay on images.

Orange curved top background with title and icons.

Page indicators for current event index.

Informative text below carousel about event booking.

2. Event List / Detail

Detailed event information (title, description, date, location, category).

Displays total seats, booked seats, and remaining seats.

User can navigate from HomeScreen carousel to Event Detail.

3. Profile Screen

Displays user name and email.

Logout button for authentication.

If user not logged in, shows login button.

4. Drawer Menu

Accessible from top-left menu icon.

Navigation to:

Home

My Bookings

Settings

Logout

Models
EventModel

Represents an event with following properties:

id

title

description

date

location

category

totalSeats

bookedSeats

remainingSeats

imageUrl

Methods:

fromJson(): Parse JSON to EventModel.

toJson(): Convert EventModel to JSON.

assetImage: Returns either imageUrl or local asset fallback (assets/images/1.jpg … 7.jpg).

State Management

Provider package is used for state management.

BookingProvider: Provides dummy events and booking state.

AuthProvider: Manages user authentication and profile information.

Assets

Stored under assets/images/

Includes 7 dummy images: 1.jpg, 2.jpg, ..., 7.jpg.

Used for event carousel and event detail screens.

Make sure to declare in pubspec.yaml:

flutter:
  assets:
    - assets/images/

Installation & Setup

Clone the repository

git clone <your-repo-url>
cd eventease


Install dependencies

flutter pub get


Add assets

Ensure assets/images/ contains 1.jpg to 7.jpg.

Verify pubspec.yaml has asset paths declared.

Set up Providers

Add BookingProvider and AuthProvider in main.dart:

MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => BookingProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ],
  child: MyApp(),
)

Run Commands

Run on connected device / emulator:

flutter run


Run on web:

flutter run -d chrome


Build APK / AppBundle:

flutter build apk
flutter build appbundle

Dependencies

flutter >= 3.0.0

provider ^6.0.0

Optional for future updates:

http for API calls

firebase_auth & cloud_firestore for backend integration

Future Enhancements

Add real backend API for events & bookings.

Integrate Firebase Authentication for user login.

Add push notifications for event updates.

Enable ticket management for booked events.

Add search and filter events functionality.

Add multi-language support for broader reach.

EventEase provides a modern, responsive, and intuitive interface to explore and book events with ease.