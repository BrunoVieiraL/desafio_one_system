import '../mock/list_mocks.dart';
import '../model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController companyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  Rx<List<InfoModel>> list = Rx<List<InfoModel>>([]);
  Rx<int> length = 0.obs;

  @override
  Widget build(BuildContext context) {
    list.value = ListMocks.companyList;
    length.value = list.value.length;
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
                        for (var i = 0; i < list.value.length; i++) {
                          idController.text == list.value[i].id.toString()
                              ? companyController.text = list.value.elementAt(i).name
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
                  itemCount: listLength.value != list.value.length
                      ? list.value.length
                      : listLength.value,
                  itemBuilder: (context, index) {
                    print('OBX: ${listLength.value}');
                    print('LENGTH: ${list.value.length}');
                    return ListTile(
                      leading: Text('${list.value[index].id.toString()} -'),
                      title: Text(list.value[index].name),
                      onTap: () {
                        idController.text = list.value[index].id.toString();
                        companyController.text = list.value[index].name;
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

  void searchInfoModel(dynamic query) {
    final newList = list.value.where((element) {
      final elementName = element.name.toLowerCase();
      final input = query.toLowerCase();
      return elementName.contains(input);
    }).toList();
    list.value = newList;
  }
}
