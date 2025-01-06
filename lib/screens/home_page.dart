import 'package:event_app/screens/detail_event_page.dart';
import 'package:flutter/material.dart';

import '../widgets/my_carousel.dart';
import 'detail_introduce_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> _events = [];

  @override
  void initState() {
    super.initState();
    _events = [
      {
        "name": "Tech Conference 2025",
        "image":
        "https://www.eventsindustryforum.co.uk/images/articles/about_the_eif.jpg",
        "date": "March 15, 2025",
        "location": "Hanoi Convention Center, Hanoi",
        "price": "1,500,000 VND",
        "organizer": "Tech Innovators Co.",
        "status": "Upcoming",
        "description":
        "Join us for an exciting tech conference where industry leaders share insights and the latest trends in technology. This event will feature top speakers, workshops, and networking opportunities."
      },
      {
        "name": "Startup Meetup 2025",
        "image":
        "https://www.eventsindustryforum.co.uk/images/articles/about_the_eif.jpg",
        "date": "April 20, 2025",
        "location": "Saigon Startup Hub, HCMC",
        "price": "Free",
        "organizer": "Startup Vietnam",
        "status": "Ongoing",
        "description":
        "A casual meetup for startup founders, investors, and enthusiasts to network and share ideas. Don't miss this opportunity to connect and collaborate!"
      }
    ];
  }

  void _handleSeeMore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailIntroducePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const MyCarousel(),
            const SizedBox(height: 24),
            const Text(
              "Introduce",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text(
              "The prospect of planning an event can trigger a lot of anxiety. It’s easy to convey that you are overwhelmed by the different types of events you can choose from. And yet, each event type plays a vital role in relevant sectors.",
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: _handleSeeMore,
                child: const Text("See more"),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Event",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            _EventList(events: _events),
          ],
        ),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  final List<Map<String, String>> events;

  const _EventList({required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: events.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final event = events[index];
            return _ItemEvent(event: event);
          },
        ),
      ],
    );
  }
}

class _ItemEvent extends StatelessWidget {
  final Map<String, String> event;

  const _ItemEvent({required this.event});

  void _handleNavigateDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailEventPage(
          eventName: event["name"]!,
          bannerImage: event["image"]!,
          description: event["description"]!,
          date: event["date"]!,
          location: event["location"]!,
          organizer: event["organizer"]!,
          status: event["status"]!,
          price: event["price"]!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleNavigateDetail(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                event["image"]!,
                height: 200,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event["name"]!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              event["date"]!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              event["location"]!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Participation fee"),
                        Text(
                          event["price"]!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
