// import 'package:flutter/material.dart';
// import 'package:handyhobby2/screens/project_detail_page.dart'; // นำเข้าหน้า ProjectDetailPage
// import 'package:handyhobby2/screens/home_page.dart';
// import 'package:handyhobby2/screens/favorite_page.dart'; // นำเข้าหน้า FavoritePage
// import 'package:shared_preferences/shared_preferences.dart'; // นำเข้า shared_preferences

// class CategoryPage extends StatefulWidget {
//   final String categoryName;

//   CategoryPage(this.categoryName);

//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   String searchQuery = '';
//   List<Map<String, dynamic>> items = [];
//   List<Map<String, dynamic>> filteredItems = [];
//   List<String> favoriteItems = []; // รายการโปรด

//   @override
//   void initState() {
//     super.initState();
//     // กำหนดรายการเริ่มต้น
//     items = _buildItemList(context, widget.categoryName);
//     filteredItems = items; // ตั้งค่า filteredItems เป็น items เริ่มต้น
//     _loadFavorites(); // โหลดรายการโปรดเมื่อเริ่มต้น
//   }

//   List<Map<String, dynamic>> _buildItemList(BuildContext context, String category) {
//    if (category == 'ถักไหมพรม') {
//       return [
//         {
//           'title': 'How to crochet | สอนถักโครเชต์พื้นฐาน',
//           'imagePath': 'assets/Basic-Crochet.jpg',
//           'description': 'วันนี้จะมาแนะนำการถักโครเชต์อย่างง่ายๆ สำหรับผู้เริ่มต้น สามารถดูแล้วถักตามได้เลย',
//           'videoId': 'Ybp3nYqes-8', // รหัสวิดีโอ YouTube ของโปรเจกต์นี้
//           'materials': ['ไหมพรม', 'เข็มถักโครเชต์', 'กรรไกร'] // อุปกรณ์สำหรับโปรเจกต์นี้
//         },
//         {
//           'title': 'Easy Crochet Bucket Hat Tutorial',
//           'imagePath': 'assets/crochet_sweater.jpg',
//           'description': 'สอนถักหมวกบัคเก็ตอย่างง่าย ๆ สำหรับมือใหม่ หวังว่าทุกคนจะชอบกันนะคะ',
//           'videoId': 'FuuCwnqJBSQ', // รหัสวิดีโอ YouTube ของโปรเจกต์นี้
//           'materials': ['ไหมพรม', 'เข็มถักโครเชต์', 'ไม้บรรทัด'] // อุปกรณ์สำหรับโปรเจกต์นี้
//         },
//       ];
//     } else if (category == 'กำไลแฮนด์เมด') {
//       return [
//         {
//           'title': 'ทำสร้อยคอ',
//           'imagePath': 'assets/necklace.jpg',
//           'description': 'ทำสร้อยคอด้วยมือเองง่าย ๆ',
//           'videoId': 'abcd1234', // รหัสวิดีโอ YouTube ของโปรเจกต์นี้
//           'materials': ['ลูกปัด', 'ด้าย', 'เข็ม', 'กรรไกร'] // อุปกรณ์สำหรับโปรเจกต์นี้
//         },
//         {
//           'title': 'ทำต่างหู',
//           'imagePath': 'assets/earrings.jpg',
//           'description': 'ทำต่างหูสวยๆ ด้วยมือเอง',
//           'videoId': 'efgh5678', // รหัสวิดีโอ YouTube ของโปรเจกต์นี้
//           'materials': ['ลวด', 'คีมดัดลวด', 'ลูกปัด'] // อุปกรณ์สำหรับโปรเจกต์นี้
//         },
//       ];
//     }
//     return [];
  
//   }

//   void _filterItems(String query) {
//     setState(() {
//       searchQuery = query;
//       filteredItems = items.where((item) {
//         return item['title']!.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   void _toggleFavorite(String title) {
//     setState(() {
//       if (favoriteItems.contains(title)) {
//         favoriteItems.remove(title);
//       } else {
//         favoriteItems.add(title);
//       }
//       _saveFavorites(); // บันทึกรายการโปรดเมื่อมีการเปลี่ยนแปลง
//     });
//   }

//   // ฟังก์ชันเพื่อโหลดรายการโปรดจาก shared_preferences
//   Future<void> _loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       favoriteItems = prefs.getStringList('favorites') ?? [];
//     });
//   }

//   // ฟังก์ชันเพื่อบันทึกรายการโปรดไปยัง shared_preferences
//   Future<void> _saveFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('favorites', favoriteItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryName),
//         backgroundColor: Colors.pink[100],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: _filterItems,
//               decoration: InputDecoration(
//                 hintText: 'ค้นหา',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(8.0),
//               children: filteredItems.map((item) {
//                 return _buildListItem(
//                   context,
//                   item['title']!,
//                   item['imagePath']!,
//                   item['description']!,
//                   item['videoId']!,
//                   item['materials'],
//                   favoriteItems.contains(item['title']), // ตรวจสอบว่าเป็นรายการโปรดหรือไม่
//                   () => _toggleFavorite(item['title']), // ฟังก์ชันสำหรับปุ่ม
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'หน้าหลัก',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'ที่บันทึกไว้',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'โปรไฟล์',
//           ),
//         ],
//         currentIndex: 0,
//         selectedItemColor: Colors.pink,
//         onTap: (index) {
//           if (index == 0) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute<dynamic>(builder: (context) => HomePage()),
//             );
//           } else if (index == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FavoritePage(favoriteItems: favoriteItems), // ส่งรายการโปรดไปยัง FavoritePage
//               ),
//             );
//           } else if (index == 2) {
//             Navigator.pushReplacementNamed(context, '/profile');
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildListItem(BuildContext context, String title, String imagePath, String description, String videoId, List<String> materials, bool isFavorite, VoidCallback onFavoritePressed) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProjectDetailPage(
//               projectTitle: title,
//               videoId: videoId,
//               materials: materials,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 8.0),
//         elevation: 2.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Stack(
//               children: [
//                 Container(
//                   height: 200.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(imagePath),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 10,
//                   top: 10,
//                   child: IconButton(
//                     icon: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: Colors.red,
//                     ),
//                     onPressed: onFavoritePressed, // ใช้ VoidCallback ที่ถูกต้อง
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     description,
//                     style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:handyhobby2/screens/project_detail_page.dart'; // นำเข้าหน้า ProjectDetailPage
import 'package:handyhobby2/screens/home_page.dart';
import 'package:handyhobby2/screens/favorite_page.dart'; // นำเข้าหน้า FavoritePage
import 'package:shared_preferences/shared_preferences.dart'; // นำเข้า shared_preferences
import 'package:http/http.dart' as http; // นำเข้า package http สำหรับการเรียก API
import 'dart:convert'; // ใช้สำหรับการแปลง JSON
import 'package:handyhobby2/screens/Profile.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  CategoryPage(this.categoryName);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchQuery = '';
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> filteredItems = [];
  List<String> favoriteItems = []; // รายการโปรด

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // โหลดรายการโปรดเมื่อเริ่มต้น
    _fetchItems(); // เรียกใช้ฟังก์ชันเพื่อดึงข้อมูลจาก API
  }

  // ฟังก์ชันเพื่อดึงข้อมูลจาก API
  Future<void> _fetchItems() async {
    final response = await http.get(Uri.parse('https://gist.githubusercontent.com/onnyluu/05e2f1183cddb723c1ff34a35ef43e09/raw/ed197f4a3b58097f315061ad4e1441cc8083faef/data.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body); // แปลงข้อมูล JSON
      setState(() {
        items = data.map((item) {
          return {
            'title': item['title'],
            'imagePath': item['imagePath'],
            'description': item['description'],
            'videoId': item['videoId'],
            'materials': List<String>.from(item['materials']),
          };
        }).toList();
        filteredItems = items; // ตั้งค่า filteredItems เป็น items เริ่มต้น
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = items.where((item) {
        return item['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _toggleFavorite(String title) {
    setState(() {
      if (favoriteItems.contains(title)) {
        favoriteItems.remove(title);
      } else {
        favoriteItems.add(title);
      }
      _saveFavorites(); // บันทึกรายการโปรดเมื่อมีการเปลี่ยนแปลง
    });
  }

  // ฟังก์ชันเพื่อโหลดรายการโปรดจาก shared_preferences
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteItems = prefs.getStringList('favorites') ?? [];
    });
  }

  // ฟังก์ชันเพื่อบันทึกรายการโปรดไปยัง shared_preferences
  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.pink[100],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'ค้นหา',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: filteredItems.map((item) {
                return _buildListItem(
                  context,
                  item['title']!,
                  item['imagePath']!,
                  item['description']!,
                  item['videoId']!,
                  item['materials'],
                  favoriteItems.contains(item['title']), // ตรวจสอบว่าเป็นรายการโปรดหรือไม่
                  () => _toggleFavorite(item['title']), // ฟังก์ชันสำหรับปุ่ม
                );
              }).toList(),
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
        currentIndex: 0,
        selectedItemColor: Colors.pink,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteItems: favoriteItems), // ส่งรายการโปรดไปยัง FavoritePage
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, String imagePath, String description, String videoId, List<String> materials, bool isFavorite, VoidCallback onFavoritePressed) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailPage(
              projectTitle: title,
              videoId: videoId,
              materials: materials,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: onFavoritePressed, // ใช้ VoidCallback ที่ถูกต้อง
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
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