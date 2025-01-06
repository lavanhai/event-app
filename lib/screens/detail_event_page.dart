import 'package:flutter/material.dart';

import 'buy_ticket_page.dart';

class DetailEventPage extends StatelessWidget {
  final String eventName;
  final String bannerImage;
  final String description;
  final String date;
  final String location;
  final String organizer;
  final String status;
  final String price;

  const DetailEventPage({
    super.key,
    required this.eventName,
    required this.bannerImage,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.status,
    required this.price,
  });

  _handleBuyTicket(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyTicketPage(
      eventName: eventName,
      eventDate: date,
      eventLocation: location,
      ticketPrice: price,),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                bannerImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              eventName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(location, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.business, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(organizer, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.event_available, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(status, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            // Giá vé
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:()=>_handleBuyTicket(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12), backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Register to participate', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
