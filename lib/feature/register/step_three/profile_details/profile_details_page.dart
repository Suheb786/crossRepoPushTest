import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page_view.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page_view_model.dart';

class ProfileDetailsPage extends BasePage<ProfileDetailsPageViewModel> {
  @override
  ProfileDetailsPageState createState() => ProfileDetailsPageState();
}

class ProfileDetailsPageState
    extends BaseStatefulPage<ProfileDetailsPageViewModel, ProfileDetailsPage> {
  @override
  ProviderBase provideBase() {
    return profileDetailsPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ProfileDetailsPageViewModel model) {
    return ProfileDetailsPageView(provideBase());
  }
}
