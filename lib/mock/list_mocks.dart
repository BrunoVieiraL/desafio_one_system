import 'package:get/get.dart';
import '../model/info_model.dart';

class ListMocks {
  static List<InfoModel> companyList = [
    InfoModel(Rx<int>(1), Rx<String>('Med Matriz')),
    InfoModel(Rx<int>(2), Rx<String>('Med Recife')),
    InfoModel(Rx<int>(3), Rx<String>('Med Fortaleza')),
  ];

  static List<InfoModel> partnerList = [];

  static List<InfoModel> procedureList = [];
}
