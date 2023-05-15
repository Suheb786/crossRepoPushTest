import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUtils {
  LaunchUrlUtils._();

  static launchDigitalService(String digitalServiceUrl) async {
    if (await canLaunchUrl(Uri.parse(digitalServiceUrl))) {
      await launchUrl(Uri.parse(digitalServiceUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $digitalServiceUrl';
    }
  }
}
