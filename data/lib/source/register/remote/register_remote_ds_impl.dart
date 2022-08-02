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
      'Facilities',
      'Others'
    ];
    List<String> purposeListAr = [
      'حويل الراتب',
      'حركات بنكية يومية',
      'وفير',
      ' بطاقة ائتمانية',
      'تسهيلات مصرفية',
      'اخرى'
    ];

    return Future.value(Future.value(Intl.getCurrentLocale() == 'en' ? purposeListEn : purposeListAr));
  }

  @override
  Future<List<AdditionalIncome>> getAdditionalIncomeSourceList() {
    List<AdditionalIncome> additionalIncomeEn = [
      AdditionalIncome(type: 'Additional Salary'),
      AdditionalIncome(type: 'Pension'),
      AdditionalIncome(type: 'Freelance Income'),
      AdditionalIncome(type: 'Bonus, Incentive, and Commission'),
      AdditionalIncome(type: 'Rental Income'),
      AdditionalIncome(type: 'Investments'),
      AdditionalIncome(type: 'Own Business'),
      AdditionalIncome(type: 'Family Allowance'),
      AdditionalIncome(type: 'Other'),
    ];
    List<AdditionalIncome> additionalIncomeAr = [
      AdditionalIncome(type: 'راتب اضافي'),
      AdditionalIncome(type: 'تب تقاعد '),
      AdditionalIncome(type: 'خل من أعمال حرة'),
      AdditionalIncome(type: 'تب اضافي , فز , مولة  '),
      AdditionalIncome(type: 'خل الايجار'),
      AdditionalIncome(type: 'ستثمار'),
      AdditionalIncome(type: 'عمل خاص'),
      AdditionalIncome(type: 'خصص عائلي'),
      AdditionalIncome(type: 'خرى'),
    ];
    return Future.value(Intl.getCurrentLocale() == 'en' ? additionalIncomeEn : additionalIncomeAr);
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
