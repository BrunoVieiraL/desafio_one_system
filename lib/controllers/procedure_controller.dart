import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/info_model.dart';
import '/controllers/generic_controller.dart';

class ProcedureController extends GenericController {
  final List<InfoModel> procedureList = [
    InfoModel(1, 'Demais'),
    InfoModel(2, 'Marcapsso'),
    InfoModel(3, 'Outro'),
  ];

  @override
  void onInit() {
    super.onInit();
    foundCompanies.value = procedureList;
  }

  @override
  void filterList(String companyname) {
    List<InfoModel> results = [];
    if (companyname.isEmpty) {
      results = procedureList;
    } else if (int.tryParse(companyname) != null) {
      results = procedureList
          .where((element) => element.id == int.parse(companyname))
          .toList();
    } else {
      results = procedureList
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
    for (var i = 0; i < procedureList.length; i++) {
      firstController == procedureList[i].id.toString()
          ? secondController.text = procedureList[i].name
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
