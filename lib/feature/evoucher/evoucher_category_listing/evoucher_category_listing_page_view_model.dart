import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class EVoucherCategoryListingPageViewModel extends BasePageViewModel {
  List<CategoryModel> categoryList = [
    CategoryModel(categoryName: 'Call of Duty® Warzone', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'League of Legends', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'Minecraft', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'Nintendo', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'PlayStation', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'PUBG', categoryImageUrl: AssetUtils.personCircle),
    CategoryModel(categoryName: 'Steam', categoryImageUrl: AssetUtils.personCircle),
  ];
}

class CategoryModel {
  final String? categoryName;
  final String? categoryImageUrl;

  CategoryModel({this.categoryName, this.categoryImageUrl});
}
