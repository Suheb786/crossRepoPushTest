import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page_view.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page_view_model.dart';

class ProfileDetailsPage extends BasePage<ProfileDetailsPageViewModel> {
  @override
  ProfileDetailsPageState createState() => ProfileDetailsPageState();
}

class ProfileDetailsPageState extends BaseStatefulPage<ProfileDetailsPageViewModel, ProfileDetailsPage> {
  @override
  ProviderBase provideBase() {
    return profileDetailsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ProfileDetailsPageViewModel model) {
    return ProfileDetailsPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ProfileDetailsPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(registerStepOneViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
