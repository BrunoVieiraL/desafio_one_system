import 'package:desafio_one_system/controllers/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pendência de Faturamento'),
          leading: const Icon(Icons.arrow_back),
          backgroundColor: const Color(0xFF1C51AE),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cabeçalho'),
              Tab(text: 'Catálogo'),
              Tab(text: 'Carrinho'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Cabeçalho de Nota',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF2B518D)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16, left: 16),
                  child: Text(
                    'Preencha as informações de cabeçalho do pedido',
                    style: TextStyle(
                        color: Color(0xFF2B518D),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: idController,
                        onChanged: (value) {
                          controller.autoComplete(value, companyController);
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
                      controller: companyController,
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
                ),
              ],
            ),
            const Center(
              child: Text('Template'),
            ),
            const Center(
              child: Text('Template'),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialogList() {
    return Get.defaultDialog(
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
                        idController.text = controller
                            .foundCompanies.value[index].id
                            .toString();
                        companyController.text =
                            controller.foundCompanies.value[index].name;
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
  }
}
