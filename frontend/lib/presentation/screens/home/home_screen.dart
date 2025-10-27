import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/home_event_card.dart';
import '../events/event_detail_screen.dart';
import '../../../data/models/event_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  // ---------- Dummy Event Data ----------
  final List<EventModel> events = [
    EventModel(
        id: "1",
        title: "Music Concert",
        description: "Live music concert featuring top bands",
        date: DateTime.now(),
        location: "New York City",
        category: "Music",
        totalSeats: 100,
        bookedSeats: 40,
        imageUrl: "assets/images/1.jpg"),
    EventModel(
        id: "2",
        title: "Tech Meetup",
        description: "Network with tech enthusiasts and experts",
        date: DateTime.now(),
        location: "San Francisco",
        category: "Tech",
        totalSeats: 80,
        bookedSeats: 25,
        imageUrl: "assets/images/2.jpg"),
    EventModel(
        id: "3",
        title: "Art Exhibition",
        description: "Explore amazing artwork by local artists",
        date: DateTime.now(),
        location: "Los Angeles",
        category: "Art",
        totalSeats: 50,
        bookedSeats: 10,
        imageUrl: "assets/images/3.jpg"),
    EventModel(
        id: "4",
        title: "Food Festival",
        description: "Taste delicious cuisines from around the world",
        date: DateTime.now(),
        location: "Chicago",
        category: "Food",
        totalSeats: 120,
        bookedSeats: 60,
        imageUrl: "assets/images/4.jpg"),
    EventModel(
        id: "5",
        title: "Startup Workshop",
        description: "Learn to launch your startup effectively",
        date: DateTime.now(),
        location: "Boston",
        category: "Business",
        totalSeats: 70,
        bookedSeats: 30,
        imageUrl: "assets/images/5.jpg"),
    EventModel(
        id: "6",
        title: "Comedy Show",
        description: "Laugh out loud with top comedians",
        date: DateTime.now(),
        location: "Las Vegas",
        category: "Entertainment",
        totalSeats: 90,
        bookedSeats: 20,
        imageUrl: "assets/images/6.jpg"),
    EventModel(
        id: "7",
        title: "Yoga Retreat",
        description: "Relax and rejuvenate at a peaceful retreat",
        date: DateTime.now(),
        location: "Hawaii",
        category: "Wellness",
        totalSeats: 40,
        bookedSeats: 5,
        imageUrl: "assets/images/7.jpg"),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % events.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            // ---------- Top Rounded Orange Background ----------
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: TopRoundedClipper(),
                child: Container(
                  height: 220,
                  color: Colors.orange.shade600,
                ),
              ),
            ),

            // ---------- Main Content ----------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // ---------- App Title & Icons ----------
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu,
                              color: Colors.white, size: 28),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      const Text(
                        "EventEase",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: Colors.white, size: 26),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // ---------- Event Cards Carousel ----------
                        SizedBox(
                          height: 160,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: events.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final event = events[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EventDetailScreen(event: event),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: HomeEventCard(
                                    event: event,
                                    height: 140,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ---------- Page Indicator ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(events.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == index ? 16 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 30),

                        // ---------- Description Text ----------
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Text(
                                " Discover and Book Exciting Events Instantly!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Find concerts, tech meetups, workshops, and parties happening near you.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "EventEase makes booking simple, fast, and secure — all in one tap!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Custom Clipper ----------
class TopRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 100,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
