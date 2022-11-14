import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/info_model.dart';

class GenericController extends GetxController {
  

  Rx<List<InfoModel>> foundCompanies = Rx<List<InfoModel>>([]);


  void filterList(String companyname) {
    
  }

  void autoComplete(
    String firstController,
    TextEditingController secondController,
  ) {}

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
