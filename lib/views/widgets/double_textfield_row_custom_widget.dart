import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/company_controller.dart';

class DoubleTextFieldRowCustomWidget extends StatelessWidget {
  const DoubleTextFieldRowCustomWidget({
    Key? key,
    required this.firstController,
    required this.controller,
    required this.secondController,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController firstController;
  final CompanyController controller;
  final TextEditingController secondController;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            controller: firstController,
            onChanged: (value) {
              controller.autoComplete(value, secondController);
            },
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 80),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.defaultDialog(
                title: ''.trim(),
                titlePadding: EdgeInsets.zero,
                content: SizedBox(
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: searchController,
                        onChanged: (value) {
                          return controller.filterList(value);
                        },
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.foundCompanies.value.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    '${controller.foundCompanies.value[index].id} - ${controller.foundCompanies.value[index].name}'),
                                onTap: () {
                                  firstController.text = controller
                                      .foundCompanies.value[index].id
                                      .toString();
                                  secondController.text = controller
                                      .foundCompanies.value[index].name;
                                  searchController.clear();
                                  controller.onInit();
                                  Get.back();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
        ),
        TextField(
          onTap: () {
            Get.defaultDialog(
              title: ''.trim(),
              titlePadding: EdgeInsets.zero,
              content: SizedBox(
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: searchController,
                      onChanged: (value) {
                        return controller.filterList(value);
                      },
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.foundCompanies.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  '${controller.foundCompanies.value[index].id} - ${controller.foundCompanies.value[index].name}'),
                              onTap: () {
                                controller.tapListTile(
                                  index: index,
                                  firstController: firstController,
                                  secondController: secondController,
                                  searchController: searchController,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          controller: secondController,
          decoration: const InputDecoration(
            constraints: BoxConstraints(maxWidth: 245),
            label: Text(
              'Empresa',
              style: TextStyle(
                  color: Color(0xFF2B518D),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            '*',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
