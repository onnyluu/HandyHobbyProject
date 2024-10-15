import 'package:flutter_test/flutter_test.dart';
import 'package:handyhobby2/screens/login_page.dart'; // เปลี่ยนให้ตรงกับ path ที่ถูกต้อง

void main() {
  group('Email Validator', () {
    final loginPage = LoginPageState(); // สร้าง instance ของ _LoginPageState

    test('Valid email returns null', () {
      expect(loginPage.emailValidator('test@example.com'), null);
    });

    test('Empty email returns error message', () {
      expect(loginPage.emailValidator(''), 'กรุณากรอกอีเมล');
    });

    test('Invalid email format returns error message', () {
      expect(loginPage.emailValidator('invalidemail'), 'กรุณากรอกอีเมลให้ถูกต้อง');
    });
  });
}
