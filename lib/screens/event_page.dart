import 'package:flutter/material.dart';

import 'detail_event_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  // Danh sách sự kiện
  final List<Map<String, String>> _events = [
    {
      "name": "Tech Conference 2025",
      "bannerImage": "https://jandevents.com/wp-content/uploads/jand-party.jpg",
      "description":
      "Join us for an exciting tech conference where industry leaders share insights and the latest trends in technology.",
      "date": "March 15, 2025",
      "location": "Hanoi Convention Center, Hanoi",
      "organizer": "Tech Innovators Co.",
      "status": "Upcoming",
      "price": "500.000 VND",
    },
    {
      "name": "Art Exhibition 2025",
      "bannerImage": "https://jandevents.com/wp-content/uploads/jand-party.jpg",
      "description":
      "Discover stunning artworks from around the globe at the annual Art Exhibition.",
      "date": "April 10, 2025",
      "location": "Art Center, Ho Chi Minh City",
      "organizer": "Artistic Minds",
      "status": "Upcoming",
      "price": "300.000 VND",
    },
    // Thêm các sự kiện khác ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return _ItemEvent(event: event);
                },
              ),
            ),
          ],
        ),
      ),
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
          eventName: event["name"] ?? "Unknown Event",
          bannerImage: event["bannerImage"] ?? "",
          description: event["description"] ?? "",
          date: event["date"] ?? "",
          location: event["location"] ?? "",
          organizer: event["organizer"] ?? "",
          status: event["status"] ?? "",
          price: event["price"] ?? "",
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
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.network(
                event["bannerImage"] ?? "",
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
                          event["name"] ?? "Unknown Event",
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
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: Text(
                                event["date"] ?? "Unknown Date",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
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
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: Text(
                                event["location"] ?? "Unknown Location",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
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
                          event["price"] ?? "Unknown Price",
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
