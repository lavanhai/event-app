import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'detail_event_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _events.isEmpty
          ? const Center(child: Text("No events available"))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return _ItemEvent(event: event);
          },
        ),
      ),
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
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
