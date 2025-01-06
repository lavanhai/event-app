import 'package:flutter/material.dart';

class DetailIntroducePage extends StatelessWidget {
  const DetailIntroducePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Introduce Details",style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://jandevents.com/wp-content/uploads/jand-party.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Event Introduction",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "The prospect of planning an event can trigger a lot of anxiety. It’s easy to convey that you are overwhelmed by the different types of events you can choose from. And yet, each event type plays a vital role in relevant sectors. There are different types of events that need careful planning and execution. Whether it’s a business conference, wedding, or birthday party, each requires unique attention to detail.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            const Text(
              "Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Planning an event includes selecting the venue, designing the atmosphere, choosing the type of entertainment, and managing all logistics. It requires a team of dedicated professionals to make the event successful. Organizers also need to consider factors like budget, timeline, and guest list, ensuring every detail is addressed to meet the objectives of the event.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
