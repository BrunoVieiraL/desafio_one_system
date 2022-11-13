import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/company_controller.dart';
import 'widgets/double_textfield_row_custom_widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyIdController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
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
                    firstController: companyIdController,
                    secondController: companyNameController,
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
}
