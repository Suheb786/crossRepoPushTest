// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(resendTime) => "Resend in ${resendTime}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountRegistration":
            MessageLookupByLibrary.simpleMessage("ACCOUNT REGISTRATION"),
        "addMobileHeader":
            MessageLookupByLibrary.simpleMessage("What’s your\nmobile number?"),
        "appName": MessageLookupByLibrary.simpleMessage("Neo Bank"),
        "changeMyNumber":
            MessageLookupByLibrary.simpleMessage("Change My Number"),
        "enterOtpHeader":
            MessageLookupByLibrary.simpleMessage("Enter 6-digit OTP sent to"),
        "enterValidMobileNumber": MessageLookupByLibrary.simpleMessage(
            "Please enter valid mobile number"),
        "enterValidOtp":
            MessageLookupByLibrary.simpleMessage("Please enter valid otp"),
        "mobileNumber": MessageLookupByLibrary.simpleMessage("Mobile Number"),
        "mobileNumberHint": MessageLookupByLibrary.simpleMessage("000 0000"),
        "resendIn": m0,
        "selectCountryHeader": MessageLookupByLibrary.simpleMessage(
            "Hello! Which country\nare you from?")
      };
}
