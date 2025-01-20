import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'detail_event_page.dart';
import '../widgets/my_carousel.dart';
import 'detail_introduce_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService =
  ApiService(baseUrl: 'http://v-mms.click/abp/api/app/');

  List<dynamic> _events = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final response = await _apiService.get(
          'activity?currentPage=1&totalRow=10&Activate=true');
      setState(() {
        _events = response['items'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
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
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : _events.isEmpty
                ? const Center(child: Text("No events available"))
                : _EventList(events: _events),
          ],
        ),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  final List<dynamic> events;

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
  final dynamic event;

  const _ItemEvent({required this.event});

  void _handleNavigateDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailEventPage(
          eventName: event["name"] ?? "Unknown Event",
          bannerImage: event["avatar"] != null
              ? "http://v-mms.click/abp/api/app/file/image?fileName=${event['avatar']}"
              : "",
          description: event["note"] ?? "",
          date: event["takesPlaceDay"] ?? "",
          location: event["address"] ?? "",
          organizer: "Unknown Organizer",
          eventId: event["id"] ?? "",
          status: event["activate"] == true ? "Active" : "Inactive",
          price: "\$${event["expectedCosts"]?.toStringAsFixed(2) ?? '0.00'}",
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
                event["avatar"] != null
                    ? "http://v-mms.click/abp/api/app/file/image?fileName=${event['avatar']}"
                    : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
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
                                event["takesPlaceDay"]?.split("T")[0] ??
                                    "Unknown Date",
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
                                event["address"] ?? "Unknown Location",
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
                          "\$${event["expectedCosts"]?.toStringAsFixed(2) ?? '0.00'}",
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
