import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON decoding
import 'edit_profile_page.dart'; // Import màn EditProfilePage

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullName = "Khách";
  String email = "";
  String phone = "";
  String avatar = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData != null) {
      final data = jsonDecode(userData);
      setState(() {
        fullName = data['user']['fullName'] ?? "Khách";
        avatar = data['user']['avatar'] ?? "";
        email = data['email'] ?? "";
        phone = data['phoneNumber'] ?? "";
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userData");
    setState(() {
      fullName = "Khách";
      email = "";
      phone = "";
      avatar = "";
    });
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );

    if (result != null) {
      _loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              child: fullName == "Khách"
                  ? Icon(
                Icons.person_outline,
                size: 80,
                color: Colors.blueAccent,
              )
                  : ClipOval(
                child: Image.network(
                  'http://v-mms.click/abp/api/app/file/image?fileName=$avatar', // URL của avatar
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Xử lý khi URL avatar không hợp lệ
                    return Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.blueAccent,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    // Hiển thị spinner khi ảnh đang tải
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Full name
            Text(
              fullName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Email and phone
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blueAccent),
              title: const Text("Email"),
              subtitle: Text(email.isNotEmpty ? email : "Chưa có thông tin"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blueAccent),
              title: const Text("Phone"),
              subtitle: Text(phone.isNotEmpty ? phone : "Chưa có thông tin"),
            ),
            const Divider(),
            const SizedBox(height: 16),
            // Action Button
            ElevatedButton.icon(
              onPressed: fullName == "Khách"
                  ? _navigateToEditProfile
                  : _logout,
              icon: Icon(fullName == "Khách"
                  ? Icons.edit
                  : Icons.logout),
              label: Text(
                fullName == "Khách" ? "Cập nhật thông tin" : "Đăng xuất",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
