import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/info_model.dart';

class CompanyController extends GetxController {
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

  void autoComplete(
    String firstController,
    TextEditingController secondController,
  ) {
    for (var i = 0; i < companyList.length; i++) {
      firstController == companyList[i].id.toString()
          ? secondController.text = companyList[i].name
          : firstController.isEmpty
              ? secondController.clear()
              : '';
    }
  }

  void tapListTile({
    required int index,
    required TextEditingController firstController,
    required TextEditingController secondController,
    required TextEditingController searchController,
  }) {
    firstController.text = foundCompanies.value[index].id.toString();
    secondController.text = foundCompanies.value[index].name;
    searchController.clear();
    onInit();
    Get.back();
  }
}
