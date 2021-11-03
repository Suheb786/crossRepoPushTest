import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';

final dashboardViewModelProvider =
    ChangeNotifierProvider.autoDispose<DashboardPageViewModel>(
  (ref) => DashboardPageViewModel(),
);
