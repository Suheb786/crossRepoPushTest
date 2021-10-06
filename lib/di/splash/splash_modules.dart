import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';

final splashViewModelProvider =
    ChangeNotifierProvider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(),
);
