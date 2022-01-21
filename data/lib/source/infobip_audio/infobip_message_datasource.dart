import 'package:infobip_mobilemessaging/models/UserData.dart';

abstract class InfobipMessageLocalDs {
  Future<bool> initInfobipMessage();
  Future<bool> showChat();
  Future<bool> saveUser(UserData userData);
}
