import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/generic_controller.dart';

class DoubleTextFieldRowCustomWidget extends StatelessWidget {
  const DoubleTextFieldRowCustomWidget({
    Key? key,
    required this.firstController,
    required this.controller,
    required this.secondController,
    required this.searchController,
    required this.floatingLabelText,
  }) : super(key: key);

  final TextEditingController firstController;
  final GenericController controller;
  final TextEditingController secondController;
  final TextEditingController searchController;
  final String floatingLabelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            keyboardType: TextInputType.number,
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
              dialogList();
            },
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
        ),
        TextField(
          onTap: () {
            dialogList();
          },
          controller: secondController,
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 245),
            label: Text(
              floatingLabelText,
              style: const TextStyle(
                  color: Color(0xFF2B518D),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
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

  Future<dynamic> dialogList() {
    return showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        child: SizedBox(
          height: 700,
          width: 400,
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Pesquise pelo código ou descrição',
                  hintStyle: TextStyle(
                      color: Color(0xFF2B518D), fontWeight: FontWeight.bold),
                ),
                controller: searchController,
                onChanged: (value) {
                  return controller.filterList(
                    value,
                  );
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.foundCompanies.value.length,
                    itemBuilder: (context, index) {
                      var listValue = controller.foundCompanies.value[index];
                      return ListTile(
                        title: Text(
                          '${listValue.id} - ${listValue.name}',
                          style: const TextStyle(
                              color: Color(0xFF2B518D),
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          controller.tapListTile(
                              index: index,
                              firstController: firstController,
                              secondController: secondController,
                              searchController: searchController);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
