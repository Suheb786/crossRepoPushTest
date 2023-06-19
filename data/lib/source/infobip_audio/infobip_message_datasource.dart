import 'package:infobip_mobilemessaging/models/user_data.dart';

abstract class InfobipMessageLocalDs {
  Future<bool> initInfobipMessage();

  Future<bool> showChat();

  Future<bool> saveUser(UserData userData);

  Future<bool> depersonalizeUser();
}
