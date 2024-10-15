import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<String> favoriteItems;

  FavoritePage({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการที่ถูกใจ'),
        backgroundColor: Colors.pink[100],
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteItems[index]),
            // เมื่อกดที่รายการโปรด สามารถนำทางไปยังหน้ารายละเอียดได้
            onTap: () {
              // นำทางไปยังหน้า Project Detail หรือทำอะไรก็ได้ตามที่ต้องการ
            },
          );
        },
      ),
    );
  }
}
