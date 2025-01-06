import 'package:event_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _profileImage =
      'https://icdn.24h.com.vn/upload/3-2024/images/2024-08-13/Cong-ty-cua-Son-Tung-M-TP-bi-buoc-boi-thuong-hon-6-ty-dong-co-quy-mo-the-nao-son-tung-1723526989-349-width740height740.jpg';

  final String _fullName = 'Nguyen Van A';

  final String _email = 'nguyenvana@example.com';

  final String _phone = '0123456789';

  _handleLogOut(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  _handleEdit(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          fullName: _fullName,
          email: _email,
          phone: _phone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: Colors.white,),
            onPressed: _handleEdit,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Ảnh đại diện
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(_profileImage),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.person, 'Full Name', _fullName),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.email, 'Email', _email),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.phone, 'Phone', _phone),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _handleLogOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
