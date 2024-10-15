import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:handyhobby2/screens/home_page.dart';
import 'package:handyhobby2/screens/Profile.dart';
import 'package:handyhobby2/screens/favorite_page.dart';

class ProjectDetailPage extends StatefulWidget {
  final String projectTitle; // ชื่อโปรเจกต์
  final String videoId; // YouTube Video ID
  final List<String> materials; // รายการอุปกรณ์

  const ProjectDetailPage({
    super.key,
    required this.projectTitle,
    required this.videoId,
    required this.materials,
  });

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId, // ใส่ Video ID ของ YouTube ที่ส่งเข้ามา
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text(widget.projectTitle), // ชื่อโปรเจกต์
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
            const SizedBox(height: 20),
            const Text(
              'อุปกรณ์ที่ต้องใช้',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.materials.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${index + 1}. ${widget.materials[index]}', // แสดงลำดับที่ 1, 2, 3 ฯลฯ
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // เพิ่มแถบนำทางด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'รายการที่ถูกใจ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
        selectedItemColor: Colors.pink,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => FavoritePage(favoriteItems: [],)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
