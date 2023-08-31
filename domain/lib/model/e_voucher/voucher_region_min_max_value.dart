import 'package:domain/model/e_voucher/voucher_min_max_value.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';

class VoucherRegionsAndMinMax {
  final VoucherMinMaxValue? minMaxRange;
  final List<VoucherRegionByCategories>? allowedRegions;

  VoucherRegionsAndMinMax({this.minMaxRange, this.allowedRegions});
}
