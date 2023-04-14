import 'package:data/helper/key_helper.dart';
import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:flutter/material.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:infobip_mobilemessaging/models/Configuration.dart';
import 'package:infobip_mobilemessaging/models/Installation.dart';
import 'package:infobip_mobilemessaging/models/LibraryEvent.dart';
import 'package:infobip_mobilemessaging/models/Message.dart';
import 'package:infobip_mobilemessaging/models/PersonalizeContext.dart';
import 'package:infobip_mobilemessaging/models/UserData.dart';

class InfobipMessageService {
  static List<String> libraryEvents = [''];

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState() async {
    debugPrint('-------Inside Init-------');
    await InfobipMobilemessaging.init(
      Configuration(
        applicationCode: KeyHelper.INFOBIP_APPLICATION_CODE,
        inAppChatEnabled: true,
        androidSettings: AndroidSettings(
          firebaseOptions: FirebaseOptions(
            apiKey: InfobipUtilsConstants.FIREBASE_API_KEY,
            applicationId: InfobipUtilsConstants.FIREBASE_APPLICATION_ID,
            projectId: InfobipUtilsConstants.FIREBASE_PROJECT_ID,
          ),
        ),
        defaultMessageStorage: true,
        iosSettings:
            IOSSettings(notificationTypes: ["alert", "badge", "sound"], forceCleanup: false, logging: true),
      ),
    );

    ///Push Notification Permission  for Android 13+
    InfobipMobilemessaging.registerForAndroidRemoteNotifications();

    InfobipMobilemessaging.on(LibraryEvent.TOKEN_RECEIVED, (String token) {
      print("--------Callback. TOKEN_RECEIVED event:------------");
      print(token);
      print("--------Callback. TOKEN_RECEIVED event:------------");

      addLibraryEvent("Token Received");
    });

    InfobipMobilemessaging.on(
        LibraryEvent.MESSAGE_RECEIVED,
        (Message message) => {
              if (message != null)
                {
                  print("--------Callback. MESSAGE_RECEIVED event:------------"),
                  print(message),
                  print("--------Callback. MESSAGE_RECEIVED event:------------"),
                  /*addLibraryEvent("Message Received"),*/
                  print(InfobipMobilemessaging.defaultMessageStorage()!.findAll())
                }
            });
    InfobipMobilemessaging.on(
        LibraryEvent.USER_UPDATED,
        (event) => {
              print("--------Callback. USER_UPDATED event:------------"),
              print(event),
              print("--------Callback. USER_UPDATED event:------------"),
              /*addLibraryEvent("User Updated")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.PERSONALIZED,
        (event) => {
              print("--------Callback. PERSONALIZED event:------------"),
              print(event),
              print("--------Callback. PERSONALIZED event:------------"),
              /*addLibraryEvent("Personalized")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.INSTALLATION_UPDATED,
        (String event) => {
              print("--------Callback. INSTALLATION_UPDATED event:------------"),
              print(event),
              print("--------Callback. INSTALLATION_UPDATED event:------------"),
              addLibraryEvent("Installation Updated")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.DEPERSONALIZED,
        (event) => {
              print("--------Callback. DEPERSONALIZED event:------------"),
              print(event),
              print("--------Callback. DEPERSONALIZED event:------------"),
              /*addLibraryEvent("Depersonalized")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.NOTIFICATION_ACTION_TAPPED,
        (event) => {
              print("--------Callback. NOTIFICATION_ACTION_TAPPED event:------------"),
              print(event),
              print("--------Callback. NOTIFICATION_ACTION_TAPPED event:------------"),
              addLibraryEvent("Notification Action Tapped")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.NOTIFICATION_TAPPED,
        (Message message) => {
              print("--------Callback. NOTIFICATION_TAPPED event:------------"),
              print(message),
              print("--------Callback. NOTIFICATION_TAPPED event:------------"),

              // callback(true),
              addLibraryEvent("Notification Tapped"),
              if (message.chat!) {print('Chat Message Tapped')}
            });
    InfobipMobilemessaging.on(
        LibraryEvent.REGISTRATION_UPDATED,
        (String token) => {
              print("--------Callback. REGISTRATION_UPDATED event:------------"),
              print(token),
              print("--------Callback. REGISTRATION_UPDATED event:------------"),
              addLibraryEvent("Registration Updated")
            });
    return true;
  }

  static void addLibraryEvent(String libraryEvent) {
    libraryEvents.add(libraryEvent);
  }

  Future<bool> showChat() async {
    InfobipMobilemessaging.resetMessageCounter();

    await InfobipMobilemessaging.showChat(shouldBePresentedModallyIOS: true);
    return true;
  }

  bool depersonalizeUser() {
    InfobipMobilemessaging.depersonalize();
    return true;
  }

  Future<bool> saveUser({required UserData userData}) async {
    print("USER EXTERNAL ID " + userData.externalUserId!);
    Installation installation = await InfobipMobilemessaging.getInstallation();
    installation.customAttributes = {'OneTimePassword': true};
    InfobipMobilemessaging.saveInstallation(installation);
    UserData user = UserData(
      firstName: userData.firstName,
      lastName: userData.lastName,
      emails: userData.emails,
      phones: userData.phones,
      gender: Gender.Male,
      customAttributes: userData.customAttributes ?? {},
      externalUserId: userData.externalUserId,
    );
    var userIdentity = UserIdentity(
      externalUserId: userData.externalUserId,
      emails: userData.emails,
      phones: userData.phones,
    );
    InfobipMobilemessaging.saveUser(user);
    InfobipMobilemessaging.personalize(
        PersonalizeContext(forceDepersonalize: true, userIdentity: userIdentity));
    return true;
  }
}
