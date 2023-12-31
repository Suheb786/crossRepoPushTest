import 'dart:async';

import 'package:data/helper/key_helper.dart';
import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:infobip_mobilemessaging/models/configuration.dart';
import 'package:infobip_mobilemessaging/models/installation.dart';
import 'package:infobip_mobilemessaging/models/library_event.dart';
import 'package:infobip_mobilemessaging/models/message.dart';
import 'package:infobip_mobilemessaging/models/personalize_context.dart';
import 'package:infobip_mobilemessaging/models/user_data.dart';

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

    InfobipMobilemessaging.on(LibraryEvent.tokenReceived, (String token) {
      debugPrint("--------Callback. TOKEN_RECEIVED event:------------");
      debugPrint(token);
      debugPrint("--------Callback. TOKEN_RECEIVED event:------------");

      addLibraryEvent("Token Received");
    });

    InfobipMobilemessaging.on(
        LibraryEvent.messageReceived,
        (Message message) => {
              if (message != null)
                {
                  debugPrint("--------Callback. MESSAGE_RECEIVED event:------------"),
                  debugPrint("--------Callback. MESSAGE_RECEIVED event:------------"),
                  /*addLibraryEvent("Message Received"),*/
                  // debugPrint(InfobipMobilemessaging.defaultMessageStorage()!.findAll())
                }
            });
    InfobipMobilemessaging.on(
        LibraryEvent.userUpdated,
        (event) => {
              debugPrint("--------Callback. USER_UPDATED event:------------"),
              debugPrint("--------Callback. USER_UPDATED event:------------"),
              /*addLibraryEvent("User Updated")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.personalized,
        (event) => {
              debugPrint("--------Callback. PERSONALIZED event:------------"),
              debugPrint("--------Callback. PERSONALIZED event:------------"),
              /*addLibraryEvent("Personalized")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.installationUpdated,
        (String event) => {
              debugPrint("--------Callback. INSTALLATION_UPDATED event:------------"),
              debugPrint("--------Callback. INSTALLATION_UPDATED event:------------"),
              addLibraryEvent("Installation Updated")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.depersonalized,
        (event) => {
              debugPrint("--------Callback. DEPERSONALIZED event:------------"),
              debugPrint("--------Callback. DEPERSONALIZED event:------------"),
              /*addLibraryEvent("Depersonalized")*/
            });
    InfobipMobilemessaging.on(
        LibraryEvent.actionTapped,
        (event) => {
              debugPrint("--------Callback. NOTIFICATION_ACTION_TAPPED event:------------"),
              debugPrint("--------Callback. NOTIFICATION_ACTION_TAPPED event:------------"),
              addLibraryEvent("Notification Action Tapped")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.notificationTapped,
        (Message message) => {
              debugPrint("--------Callback. NOTIFICATION_TAPPED event:------------"),
              debugPrint("--------Callback. NOTIFICATION_TAPPED event:------------"),

              // callback(true),
              addLibraryEvent("Notification Tapped"),
              if (message.chat!) {debugPrint('Chat Message Tapped')}
            });
    InfobipMobilemessaging.on(
        LibraryEvent.registrationUpdated,
        (String token) => {
              debugPrint("--------Callback. REGISTRATION_UPDATED event:------------"),
              debugPrint("--------Callback. REGISTRATION_UPDATED event:------------"),
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

  Future<bool> depersonalizeUser() {
    Completer<bool> completer = Completer<bool>();
    InfobipMobilemessaging.depersonalize();
    InfobipMobilemessaging.on(LibraryEvent.depersonalized, (event) {
      if (!completer.isCompleted) {
        completer.complete(true);
      }
    });

    return completer.future;
  }

  Future<bool> saveUser({required UserData userData}) async {
    Installation installation = await InfobipMobilemessaging.getInstallation();
    installation.customAttributes = {'OneTimePassword': true};
    InfobipMobilemessaging.saveInstallation(installation).onError((error, stackTrace) {
      debugPrint('Error ');
    });
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

    await InfobipMobilemessaging.personalize(
            PersonalizeContext(forceDepersonalize: true, userIdentity: userIdentity))
        .onError((error, stackTrace) async {
      switch ((error as services.PlatformException).code) {
        case 'PHONE_INVALID':
          {
            //the phone provided was not recognized as a valid one

            var userIdentityWithoutPhone = UserIdentity(
              externalUserId: userData.externalUserId,
              emails: userData.emails,
              phones: [],
            );

            await InfobipMobilemessaging.personalize(
                PersonalizeContext(forceDepersonalize: true, userIdentity: userIdentityWithoutPhone));
          }
          break;
        case 'EMAIL_INVALID':
          {
            //the email provided was not recognized as a valid one

            var userIdentityWithoutEmail = UserIdentity(
              externalUserId: userData.externalUserId,
              emails: [],
              phones: userData.phones,
            );

            await InfobipMobilemessaging.personalize(
                PersonalizeContext(forceDepersonalize: true, userIdentity: userIdentityWithoutEmail));
          }
          break;
        case 'AMBIGUOUS_PERSONALIZE_CANDIDATES':
          {
            //several People profiles satisfy supplied user identity, check at Customer Portal
          }
          break;
        default:
          {
            debugPrint('MobileMessaging: error is $error');
          }
      }
      debugPrint('Error Type Personalize ------>${error}');
    });

    await InfobipMobilemessaging.saveUser(user).onError((error, stackTrace) async {
      debugPrint('Error Type Save User ------>${error}');
      switch ((error as services.PlatformException).code) {
        case 'PHONE_INVALID':
          {
            //the phone provided was not recognized as a valid one

            var userWithoutPhone = UserData(
              firstName: userData.firstName,
              lastName: userData.lastName,
              emails: userData.emails,
              gender: Gender.Male,
              phones: [],
              customAttributes: userData.customAttributes ?? {},
              externalUserId: userData.externalUserId,
            );

            await InfobipMobilemessaging.saveUser(userWithoutPhone);
          }
          break;
        case 'EMAIL_INVALID':
          {
            //the email provided was not recognized as a valid one
            var userWithoutEmail = UserData(
              firstName: userData.firstName,
              lastName: userData.lastName,
              emails: [],
              gender: Gender.Male,
              phones: userData.phones,
              customAttributes: userData.customAttributes ?? {},
              externalUserId: userData.externalUserId,
            );

            await InfobipMobilemessaging.saveUser(userWithoutEmail);
          }
          break;
        case 'AMBIGUOUS_PERSONALIZE_CANDIDATES':
          {
            //several People profiles satisfy supplied user identity, check at Customer Portal
          }
          break;
        default:
          {
            debugPrint('MobileMessaging: error is $error');
          }
      }
    });

    return true;
  }
}
// safe watch down ask to amta with invalid phone number
