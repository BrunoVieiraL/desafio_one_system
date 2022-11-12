import '../mock/list_mocks.dart';
import '../model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<InfoModel> list = ListMocks.companyList;
  Rx<int> length = 0.obs;

  @override
  Widget build(BuildContext context) {
    length.value = list.length;
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
                  children: [
                    TextField(
                      controller: idController,
                      onChanged: (value) {
                        for (var i = 0; i < list.length; i++) {
                          idController.text == list[i].id.value.toString()
                              ? companyController.text =
                                  list.elementAt(i).name.value
                              : '';
                        }
                      },
                      decoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 90),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        dialogList(length);
                      },
                      icon: const Icon(Icons.search),
                    ),
                    TextField(
                      onTap: () {
                        dialogList(length);
                      },
                      controller: companyController,
                      decoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 270),
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
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
                  itemCount: listLength.value != list.length
                      ? list.length
                      : listLength.value,
                  itemBuilder: (context, index) {
                    print('OBX: ${listLength.value}');
                    print('LENGTH: ${list.length}');
                    return ListTile(
                      leading: Text('${list[index].id.value.toString()} -'),
                      title: Text(list[index].name.value),
                      onTap: () {
                        idController.text = list[index].id.value.toString();
                        companyController.text = list[index].name.value;
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

  void searchInfoModel(dynamic search) {
    final newList = list.where((element) {
      final elementName = element.name.value.toLowerCase();
      final textfieldInput = search.toLowerCase();
      return elementName.contains(textfieldInput);
    }).toList();
    list = newList;
    Get.forceAppUpdate();
  }
}
