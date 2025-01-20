import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_service.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  late ApiService apiService;
  List<dynamic> tickets = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://v-mms.click/abp/api/app/');
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString("userData");
      String? email;
      String? phoneNumber;
      if (userData != null) {
        final data = jsonDecode(userData);
        email = data['email'];
        phoneNumber = data['phoneNumber'];
      }

      if (email == null || phoneNumber == null) {
        setState(() {
          errorMessage = 'Data empty';
          isLoading = false;
        });
        return;
      }

      final String endpoint = 'ticket?PhoneNumber=$phoneNumber&Email=$email';

      final response = await apiService.get(endpoint);

      if (response != null && response is Map<String, dynamic>) {
        setState(() {
          tickets = response['items'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception("Invalid API response format.");
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Đã xảy ra lỗi: $e';
        isLoading = false;
      });
    }
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket['code'] ?? 'No Code',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${ticket['email'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${ticket['phoneNumber'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              'Money: \$${ticket['money']?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Quantity: ${ticket['quantity'] ?? 0}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Tickets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(fontSize: 14, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              : tickets.isEmpty
                  ? const Center(
                      child: Text(
                        'No tickets purchased yet.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return _buildTicketCard(tickets[index]);
                      },
                    ),
    );
  }
}
