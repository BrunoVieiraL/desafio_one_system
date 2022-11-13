import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/company_controller.dart';
import 'widgets/double_textfield_row_custom_widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final controller = Get.put(CompanyController());

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
                DoubleTextFieldRowCustomWidget(
                    firstController: idController,
                    secondController: companyController,
                    searchController: searchController,
                    controller: controller),
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
                              firstController: idController,
                              secondController: companyController,
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
