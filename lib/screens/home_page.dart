import 'package:flutter/material.dart';
import 'category_page.dart'; 
import 'favorite_page.dart';
import 'Profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String searchText = '';
  List<String> favoriteItems = []; // รายการโปรด

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(favoriteItems: favoriteItems),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute<dynamic>(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(
          'HandyHobby',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value; // อัปเดตคำค้นหา
                });
              },
              decoration: InputDecoration(
                hintText: 'ค้นหา',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('หมวดหมู่', style: TextStyle(fontSize: 18)),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8.0),
              children: _buildFilteredCategories(), // แสดงหมวดหมู่ที่กรองแล้ว
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped, // ใช้ฟังก์ชันที่สร้างไว้
      ),
    );
  }

  List<Widget> _buildFilteredCategories() {
    List<Map<String, String>> categories = [
      {'name': 'ถักไหมพรม', 'image': 'assets/knitting.jpg'},
      {'name': 'กำไลแฮนด์เมด', 'image': 'assets/handmade-bracelets.jpg'},
      {'name': 'ผ้ามัดย้อม', 'image': 'assets/scented-candle.jpg'},
      {'name': 'สมุดบันทึก', 'image': 'assets/notebook.jpg'},
    ];

    return categories
        .where((category) =>
            category['name']!.toLowerCase().contains(searchText.toLowerCase()))
        .map((category) => _buildCategoryButton(context, category['name']!, category['image']!))
        .toList();
  }

  Widget _buildCategoryButton(BuildContext context, String categoryName, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // เพิ่มไอเท็มไปยังรายการโปรดเมื่อมีการเลือกหมวดหมู่
          favoriteItems.add(categoryName);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryPage(categoryName)),
        );
      },
      child: Card(
        color: Colors.pink[50],
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryName,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
