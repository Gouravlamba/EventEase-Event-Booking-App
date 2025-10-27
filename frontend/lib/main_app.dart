import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import 'state_management/providers/auth_provider.dart';
import 'state_management/providers/event_provider.dart';
import 'state_management/providers/booking_provider.dart';
import 'presentation/widgets/bottom_navbar.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        title: 'EventEase',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        // ✅ Directly go to main screen — skip auth completely
        home: const BottomNavBar(),

        // If you still want routes for later
        routes: {
          '/main': (context) => const BottomNavBar(),
        },
      ),
    );
  }
}
