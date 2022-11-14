import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/info_model.dart';
import '../controllers/generic_controller.dart';

class PartnerController extends GenericController {
  final List<InfoModel> partnerList = [
    InfoModel(6, 'Fundação Bahiana de Cardiologia'),
    InfoModel(8, 'FAPEX'),
    InfoModel(15, 'Hospital PROHOPE'),
  ];

  @override
  void onInit() {
    super.onInit();
    foundCompanies.value = partnerList;
  }

  @override
  void filterList(String companyname) {
    List<InfoModel> results = [];
    if (companyname.isEmpty) {
      results = partnerList;
    } else if (int.tryParse(companyname) != null) {
      results = partnerList
          .where((element) => element.id == int.parse(companyname))
          .toList();
    } else {
      results = partnerList
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
    for (var i = 0; i < partnerList.length; i++) {
      firstController == partnerList[i].id.toString()
          ? secondController.text = partnerList[i].name
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
