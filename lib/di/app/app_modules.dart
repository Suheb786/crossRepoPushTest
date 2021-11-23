import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/main/app_viewmodel.dart';

ChangeNotifierProvider<AppViewModel> appViewModel =
    ChangeNotifierProvider<AppViewModel>(
  (ref) => AppViewModel(),
);
