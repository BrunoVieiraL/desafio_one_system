import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/info_model.dart';
import '../controllers/generic_controller.dart';

class CompanyController extends GenericController {
  final List<InfoModel> companyList = [
    InfoModel(1, 'Med Matriz'),
    InfoModel(2, 'Med Recife'),
    InfoModel(3, 'Med Fortaleza'),
  ];

  @override
  void onInit() {
    super.onInit();
    foundCompanies.value = companyList;
  }

  @override
  void filterList(String companyname) {
    List<InfoModel> results = [];
    if (companyname.isEmpty) {
      results = companyList;
    } else if (int.tryParse(companyname) != null) {
      results = companyList
          .where((element) => element.id == int.parse(companyname))
          .toList();
    } else {
      results = companyList
          .where((element) =>
              element.name.toLowerCase().contains(companyname.toLowerCase()))
          .toList();
    }
    foundCompanies.value = results;
  }

  @override
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

  @override
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
