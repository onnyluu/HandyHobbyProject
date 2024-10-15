import 'package:flutter/material.dart';
import 'package:handyhobby2/screens/home_page.dart';
import 'package:handyhobby2/screens/login_page.dart';
import 'package:handyhobby2/screens/favorite_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = "Somying"; // ชื่อเริ่มต้น
  int _currentIndex = 2; // กำหนดให้เป็นหน้าโปรไฟล์

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('HandyHobby', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pink[200],
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              firstName, // แสดงชื่อ
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30), // ระยะห่างระหว่างชื่อกับปุ่มแก้ไขโปรไฟล์
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      firstName: firstName, // ส่งชื่อปัจจุบันไปยังหน้าแก้ไข
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    firstName = result; // รับค่าใหม่จากหน้าแก้ไขโปรไฟล์
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 225, 73, 142),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child:
                  Text('แก้ไขโปรไฟล์', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            ElevatedButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context); // แสดงข้อความยืนยันการออกจากระบบ
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // สีของปุ่มออกจากระบบ
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('ออกจากระบบ', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink[100],
        currentIndex: _currentIndex, // ตั้งค่า currentIndex ให้ตรงกับหน้าปัจจุบัน
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'รายการที่ถูกใจ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // อัปเดต currentIndex
          });
          if (index == 0) {
            // ไปที่หน้าแรก
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage())
              );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritePage(favoriteItems: [],))
            );
          }
        },
      ),
    );
  }

  // ฟังก์ชันแสดงข้อความยืนยันการออกจากระบบ
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการออกจากระบบ'),
          content: Text('คุณต้องการออกจากระบบใช่ไหม?'),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
            TextButton(
              child: Text('ออกจากระบบ'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false, // ล้าง stack ทั้งหมดและแสดงหน้า LoginPage
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String firstName;

  EditProfilePage({required this.firstName});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName); // ควบคุมฟิลด์ชื่อ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HandyHobby',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20), // ระยะห่างจาก AppBar
            Text(
              'แก้ไขโปรไฟล์',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'), // รูปภาพจาก assets
            ),
            SizedBox(height: 20),
            TextField(
              controller: firstNameController, // ฟิลด์ชื่อ
              decoration: InputDecoration(
                labelText: 'ชื่อ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 40), // ระยะห่างระหว่างฟิลด์กับปุ่มยืนยัน
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, firstNameController.text); // ส่งชื่อที่ถูกแก้ไขกลับไป
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.pink[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'ยืนยัน',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
