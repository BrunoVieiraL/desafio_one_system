import 'package:get/get.dart';

import '../models/info_model.dart';

class HomeController extends GetxController {
  final List<InfoModel> companyList = [
    InfoModel(1, 'Med Matriz'),
    InfoModel(2, 'Med Recife'),
    InfoModel(3, 'Med Fortaleza'),
  ];

  Rx<List<InfoModel>> foundCompanies = Rx<List<InfoModel>>([]);

  @override
  void onInit() {
    super.onInit();
    foundCompanies.value = companyList;
  }

  void filterList(String companyname) {
    List<InfoModel> results = [];
    if (companyname.isEmpty) {
      results = companyList;
    } else {
      results = companyList
          .where((element) =>
              element.name.toLowerCase().contains(companyname.toLowerCase()))
          .toList();
    }
    foundCompanies.value = results;
  }
}
