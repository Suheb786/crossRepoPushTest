import 'package:data/source/register/register_datasource.dart';
import 'package:domain/model/register/additional_income.dart';
import 'package:intl/intl.dart';

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  @override
  Future<List<String>> getOccupationList() {
    return Future.value([
      'Accountant',
      'Actor',
      'Aerospace Engineer',
      'Agricultural Consultant',
      'Army',
      'Engineer',
      'Technician',
      'Software Developer',
      'Teacher',
      'Pharmacist',
      'Biomedical Engineer',
      'Psychologist',
      'Scientist',
      'Veterinarian',
      'Consultant',
      'Architect',
      'Radiographer'
    ]);
  }

  @override
  Future<List<String>> getPurposeOfAccountOpeningList() {
    List<String> purposeListEn = [
      'Salary Transfer',
      'Normal Daily Banking',
      'Saving',
      'Credit Card',
      'Facilities' /*,
      'Others'*/
    ];
    List<String> purposeListAr = [
      'تحويل راتب',
      'تعاملات مصرفية يومية',
      'توفير',
      'بطاقة ائتمانية',
      'تسهيلات' /*,
      'أخرى'*/
    ];

    return Future.value(Future.value(Intl.getCurrentLocale() == 'en' ? purposeListEn : purposeListAr));
  }

  @override
  Future<List<AdditionalIncome>> getAdditionalIncomeSourceList() {
    List<AdditionalIncome> additionalIncomeEn = [
      AdditionalIncome(type: 'Additional Salary', typeAr: 'راتب إضافي'),
      AdditionalIncome(type: 'Pension', typeAr: "راتب تقاعد"),
      AdditionalIncome(type: 'Freelance Income', typeAr: "الدخل المستقل"),
      AdditionalIncome(type: 'Bonus, Incentives, and Commission', typeAr: "مكافئات وأجور وعمولات"),
      AdditionalIncome(type: 'Rental Income', typeAr: 'عائد من الإيجارات'),
      AdditionalIncome(type: 'Investments', typeAr: "استثمارات"),
      AdditionalIncome(type: 'Own Business', typeAr: 'عمل حر'),
      AdditionalIncome(type: 'Family Allowance', typeAr: "بدل الأسرة"),
      AdditionalIncome(type: 'Other', typeAr: 'أخرى'),
    ];

    return Future.value(additionalIncomeEn);
  }

  @override
  Future<List<String>> getBusinessTypeList() {
    return Future.value([
      'Car Dealership',
      'Jewelery Business',
      'Law Firm',
      'Gas Station',
      'Bakery',
      'Exchange House',
      'Real Estate',
      'Audit & Accounting Firm',
      'Other'
    ]);
  }
}
