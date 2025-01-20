import 'dart:convert';
import 'package:event_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyTicketPage extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String ticketPrice;
  final String activityId; // Thêm ID của event

  const BuyTicketPage({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.ticketPrice,
    required this.activityId,
  });

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int _ticketCount = 1;
  String? _memberId;
  bool _userExist = false;
  final ApiService _apiService = ApiService(baseUrl: 'http://v-mms.click/abp/api');

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  /// Lấy thông tin user từ SharedPreferences
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData != null) {
      _userExist = true;
      final data = jsonDecode(userData);
      setState(() {
        _nameController.text = data['user']['fullName'] ?? "Khách";
        _emailController.text = data['email'] ?? "";
        _phoneController.text = data['phoneNumber'] ?? "";
        _memberId = data?['id'];
      });
    }
  }

  void _registerTicket() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields')),
      );
      return;
    }
    _handleSendRequestRegister();
  }

  Future<void> _handleSendRequestRegister() async {
    final requestPayload = {
      if (_memberId != null) "memberId": _memberId, // Chỉ thêm nếu có memberId
      "activityId": widget.activityId,
      "phoneNumber": _phoneController.text,
      "quantity": _ticketCount,
      "email": _emailController.text,
      "name": _nameController.text,
    };

    try {
      final response = await _apiService.post('/app/ticket', body: requestPayload);
      if (response != null) {
        _showMessageSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register ticket. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _showMessageSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful'),
        content: Text(
          'You have successfully registered $_ticketCount ticket(s) for ${widget.eventName}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _getTotalPrice() {
    double priceValue = double.parse(widget.ticketPrice.replaceAll("\$", ""));
    double totalPrice = priceValue * _ticketCount;
    return '\$${totalPrice.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buy Ticket',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.eventName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Date: ${widget.eventDate}'),
            Text('Location: ${widget.eventLocation}'),
            Text('Price per ticket: ${widget.ticketPrice}'),
            const Divider(height: 32),
            const Text(
              'Enter your information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              enabled: !_userExist,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              enabled: !_userExist,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              enabled: !_userExist,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Number of Tickets:',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_ticketCount > 1) {
                          setState(() {
                            _ticketCount--;
                          });
                        }
                      },
                    ),
                    Text(
                      '$_ticketCount',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _ticketCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Total Price: ${_getTotalPrice()}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Register Ticket',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
