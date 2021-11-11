import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view_model.dart';

class ReviewApplicationPage extends BasePage<ReviewApplicationPageViewModel> {
  @override
  ReviewApplicationPageState createState() => ReviewApplicationPageState();
}

class ReviewApplicationPageState extends BaseStatefulPage<
    ReviewApplicationPageViewModel, ReviewApplicationPage> {
  @override
  ProviderBase provideBase() {
    return reviewApplicationPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ReviewApplicationPageViewModel model) {
    return ReviewApplicationPageView(provideBase());
  }
}
