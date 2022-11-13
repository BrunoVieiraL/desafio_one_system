import '../mock/list_mocks.dart';
import '../models/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  Rx<List<InfoModel>> companyList = Rx<List<InfoModel>>(ListMocks.companyList);
  Rx<int> length = Rx<int>(0);

  @override
  Widget build(BuildContext context) {
    length.value = companyList.value.length;
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
                          for (var i = 0; i < companyList.value.length; i++) {
                            idController.text ==
                                    companyList.value[i].id.toString()
                                ? companyController.text =
                                    companyList.value.elementAt(i).name
                                : idController.text.isEmpty
                                    ? companyController.clear()
                                    : '';
                          }
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
                          dialogList(length);
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        ),
                      ),
                    ),
                    TextField(
                      onTap: () {
                        dialogList(length);
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

  Future<dynamic> dialogList(Rx<int> listLength) {
    return Get.defaultDialog(
      title: '',
      content: SizedBox(
        height: 400,
        width: 300,
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: searchController,
              onChanged: searchInfoModel,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: listLength.value != companyList.value.length
                      ? companyList.value.length
                      : listLength.value,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          Text('${companyList.value[index].id.toString()} -'),
                      title: Text(companyList.value[index].name),
                      onTap: () {
                        idController.text =
                            companyList.value[index].id.toString();
                        companyController.text = companyList.value[index].name;
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

  void searchInfoModel(String query) {
    final newList = companyList.value.where((element) {
      final elementName = element.name.toLowerCase();
      final input = query.toLowerCase();
      return elementName.contains(input);
    }).toList();
    companyList.value = newList;
  }
}
