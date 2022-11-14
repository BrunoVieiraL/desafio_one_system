import 'package:desafio_one_system/controllers/partner_controller.dart';
import 'package:desafio_one_system/controllers/procedure_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/company_controller.dart';
import 'widgets/double_textfield_row_custom_widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyIdController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController partnerIdController = TextEditingController();
  TextEditingController partnerNameController = TextEditingController();
  TextEditingController procedureIdController = TextEditingController();
  TextEditingController procedureNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final controllerCompany = Get.put(CompanyController());
  final controllerPartner = Get.put(PartnerController());
  final controllerProcedure = Get.put(ProcedureController());

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
                  controller: controllerCompany,
                  floatingLabelText: 'Empresa',
                ),
                const SizedBox(height: 10),
                DoubleTextFieldRowCustomWidget(
                  firstController: partnerIdController,
                  secondController: partnerNameController,
                  searchController: searchController,
                  controller: controllerPartner,
                  floatingLabelText: 'Parceiro',
                ),
                const SizedBox(height: 10),
                DoubleTextFieldRowCustomWidget(
                  firstController: procedureIdController,
                  controller: controllerProcedure,
                  secondController: procedureNameController,
                  searchController: searchController,
                  floatingLabelText: 'Linha do Procedimento',
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
}
