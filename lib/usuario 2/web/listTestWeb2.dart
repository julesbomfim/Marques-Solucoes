import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/usuario%202/web/authetic2.dart';
import 'package:flutter_web/usuario%202/repository2/firebase/user_docs_dialog.dart';
import 'package:flutter_web/utils/alert.dart';
import 'package:flutter_web/utils/alert2.dart';
import 'package:flutter_web/utils/loandig.dart';
import 'package:flutter_web/utils/masks.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class listWeb2 extends StatefulWidget {
  final List<Usua> users;

  const listWeb2({super.key, required this.users});

  @override
  State<listWeb2> createState() => _listWeb2State();
}

class _listWeb2State extends State<listWeb2> {
  final statusValue = ValueNotifier('');
  final dropCategoria = ['Finalizado', 'Pendente'];
  AuthService2 authService2 = AuthService2();
  //final List<Map<String, dynamic>>? files = [];
  List<Map<String, dynamic>>? files;

/////// delete
  @override
  void initState() {
    super.initState();
    fetchFiles(widget.users[0].id);
  }

  Future<void> fetchFiles(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Clientes2')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        // Check if the 'docs' field is a List<Map<String, dynamic>>
        dynamic docsData = snapshot.get('docs');

        if (docsData is List) {
          setState(() {
            files = List<Map<String, dynamic>>.from(
                (docsData).whereType<Map<String, dynamic>>());
          });
        } else {
          print('Invalid data structure for "docs" field in Firestore.');
        }
      } else {
        print('Document not found for user $userId.');
      }
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  Future<void> deleteFile(String userId, String fileName) async {
    try {
      // Find the user in the list
      Usua user = widget.users.firstWhere((user) => user.id == userId);

      // Delete file from Firebase Storage
      await FirebaseStorage.instance.ref('arquivos/$userId/$fileName').delete();

      // Update Firestore collection after deletion
      final updatedDocs = user.docs.where((doc) => doc != fileName).toList();

      // Update the 'docs' field for the user in Firestore
      await FirebaseFirestore.instance
          .collection('Clientes2')
          .doc(userId)
          .update({'docs': updatedDocs});

      setState(() {
        // Update local user's documents list after deletion
        user.docs = updatedDocs;
      });

      print('User $userId - File $fileName deleted successfully!');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

//////////// updata
  List<PlatformFile> selectedFiles = [];

  Future<List<Map<String, dynamic>>?>? selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: true);

    if (result != null) {
      selectedFiles = result.files;
      return selectedFiles
          .map((file) => {
                'name': file.name,
                'bytes': file.bytes,
              })
          .toList();
    }

    return null;
  }

  Future<void> updateFiles(String userId) async {
    List<String> fileNames = [];

    for (var file in selectedFiles) {
      try {
        // Replace with the actual user ID
        String fileName = file.name ?? 'unknown_file';

        // Upload the file to Firebase Storage
        await FirebaseStorage.instance
            .ref('arquivos/$userId/$fileName')
            .putData(file.bytes!.buffer.asUint8List());

        // Adiciona o nome do arquivo à lista
        fileNames.add(fileName);

        // Atualiza a lista de arquivos no Firestore
        await FirebaseFirestore.instance
            .collection('Clientes2')
            .doc(userId)
            .update({'docs': FieldValue.arrayUnion(fileNames)});

        print('Files updated successfully!');
      } catch (e) {
        print('Error updating files: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController pre = TextEditingController();
    TextEditingController nomeCliente = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController cpf = TextEditingController();
    TextEditingController data = TextEditingController();
    TextEditingController anotacoes = TextEditingController();

    final allusua = widget.users;
    return ListView.builder(
        itemCount: allusua.length,
        itemBuilder: (context, index) {
          final user = allusua[index];

          status() {
            if (user.status.toString() == 'Pendente') {
              return Row(children: [
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 127, 22),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: Center(
                        child: Text(user.status.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20))))
              ]);
            } else {
              return Row(children: [
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 22, 230, 57),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: Center(
                        child: Text(user.status.toString(),
                            style:
                                const TextStyle(color: Colors.white, fontSize: 20))))
              ]);
            }
          }

          return Card(
              elevation: 8,
              color: const Color(0xFF1b263b),
              child: ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: Text(user.nome,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  subtitle: status(),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF1b263b).withOpacity(0.5),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            )),
                        child: Image.asset(
                          ('assets/imagem1.png'),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      )),
                  // Define the shape of the card
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  // Define how the card's content should be clipped

                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widget of the card
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add padding around the row widget
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Add an image widget to display an image

                              // Add some spacing between the image and the text
                              Container(width: 20),
                              // Add an expanded widget to take up the remaining horizontal space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add some spacing between the top of the card and the title

                                    // Add a title widget

                                    Container(height: 10),
                                    Text('Serviço: ${user.servico.toString()}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20)),

                                    Container(height: 10),
                                    Text(
                                        'Valor a ser pago: R\$ ${user.preco.toString()} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    // Add some spacing between the title and the subtitle
                                    Container(height: 10),

                                    Text('Data: ${user.data.toString()} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    Text(
                                        'Anotações:  ${user.anotacoes.toString()} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    // Add some spacing between the title and the subtitle
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(children: [
                                      const SizedBox(
                                        width: 120,
                                      ),
                                      Container(
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) =>
                                                    AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              6),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF1b263b),
                                                      content:
                                                          UserDocsDialogBody2(
                                                              user: user),
                                                    )));
                                          },
                                          child: const Icon(
                                            Icons.description,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: TextButton(
                                              onPressed: () {
                                                String radioValue = '';
                                                nomeCliente.text = user.nome;
                                                email.text = user.email;
                                                cpf.text = user.cpf;
                                                pre.text =
                                                    user.preco.toString();
                                                radioValue =
                                                    user.servico.toString();
                                                statusValue.value =
                                                    user.status.toString();
                                                data.text =
                                                    user.data.toString();
                                                anotacoes.text =
                                                    user.anotacoes.toString();

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        ((context) =>
                                                            AlertDialog(
                                                              insetPadding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF1b263b),
                                                              content:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          650,
                                                                      width:
                                                                          650,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: const Color(0xFF1b263b).withOpacity(0.5),
                                                                          border: Border.all(
                                                                            color:
                                                                                const Color(0xFF1b263b),
                                                                          )),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                child: SizedBox(
                                                                                  height: 60,
                                                                                  width: 350,
                                                                                  child: TextFormField(
                                                                                      controller: nomeCliente,
                                                                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                      decoration: const InputDecoration(
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(
                                                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                                                            ),
                                                                                          ),
                                                                                          border: UnderlineInputBorder(),
                                                                                          labelText: 'Nome',
                                                                                          labelStyle: TextStyle(color: Colors.white, fontSize: 10))),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                child: SizedBox(
                                                                                  height: 60,
                                                                                  width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: cpf,
                                                                                    keyboardType: TextInputType.number,
                                                                                    inputFormatters: [
                                                                                      cpfMask
                                                                                    ],
                                                                                    style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                    decoration: const InputDecoration(
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderSide: BorderSide(
                                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                                          ),
                                                                                        ),
                                                                                        border: UnderlineInputBorder(),
                                                                                        labelText: 'CPF',
                                                                                        labelStyle: TextStyle(color: Colors.white, fontSize: 10)),
                                                                                    validator: (text) {
                                                                                      if (text == null || text.isEmpty) {
                                                                                        return 'Campo requerido!';
                                                                                      }

                                                                                      if (text.length != 14) {
                                                                                        return 'CPF incompleto!';
                                                                                      }

                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                              children: [
                                                                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                    child: SizedBox(
                                                                                      height: 60,
                                                                                      width: 250,
                                                                                      child: TextFormField(
                                                                                          controller: email,
                                                                                          style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                          decoration: const InputDecoration(
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                                ),
                                                                                              ),
                                                                                              border: UnderlineInputBorder(),
                                                                                              labelText: 'Email',
                                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 10))),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                    child: SizedBox(
                                                                                      height: 60,
                                                                                      width: 140,
                                                                                      child: TextFormField(
                                                                                          controller: pre,
                                                                                          keyboardType: TextInputType.number,
                                                                                          inputFormatters: [ThousandsFormatter(allowFraction: true, formatter: NumberFormat('##' '.##'))],
                                                                                          style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                          decoration: const InputDecoration(
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                                ),
                                                                                              ),
                                                                                              border: UnderlineInputBorder(),
                                                                                              prefix: Text(
                                                                                                'R\$ ',
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                              labelText: 'Preço ',
                                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 10))),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                    child: SizedBox(
                                                                                      height: 60,
                                                                                      width: 140,
                                                                                      child: TextFormField(
                                                                                        controller: data,
                                                                                        style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                        decoration: const InputDecoration(
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(
                                                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                                                              ),
                                                                                            ),
                                                                                            border: UnderlineInputBorder(),
                                                                                            labelText: 'Data',
                                                                                            labelStyle: TextStyle(color: Colors.white, fontSize: 10)),
                                                                                        onTap: () async {
                                                                                          DateTime? pickeddate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                                                                                          if (pickeddate != null) {
                                                                                            setState(() {
                                                                                              data.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                                                                                            });
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ]),
                                                                                Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                                                                                      child: SizedBox(
                                                                                        width: 560,
                                                                                        child: TextField(
                                                                                          maxLines: 5,
                                                                                          controller: anotacoes,
                                                                                          style: const TextStyle(fontSize: 15, color: Colors.white),
                                                                                          decoration: const InputDecoration(
                                                                                              fillColor: Color.fromARGB(255, 21, 30, 46),
                                                                                              filled: true,
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                                ),
                                                                                              ),
                                                                                              border: UnderlineInputBorder(),
                                                                                              labelText: 'Anotações',
                                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 10)),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Column(children: [
                                                                                  Row(children: [
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            margin: const EdgeInsets.symmetric(horizontal: 30),
                                                                                            child: ListTile(
                                                                                              title: const Text("PROJETO BB", style: TextStyle(color: Colors.white)),
                                                                                              leading: Radio(
                                                                                                  value: 'PROJETO BB',
                                                                                                  activeColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                  groupValue: radioValue,
                                                                                                  onChanged: (value) {
                                                                                                    setState(() {
                                                                                                      radioValue = value.toString();
                                                                                                    });
                                                                                                  }),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: const EdgeInsets.symmetric(horizontal: 30),
                                                                                            child: ListTile(
                                                                                              title: const Text("CCIR e ITR", style: TextStyle(color: Colors.white)),
                                                                                              leading: Radio(
                                                                                                  value: 'CCIR e ITR',
                                                                                                  activeColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                  groupValue: radioValue,
                                                                                                  onChanged: (value) {
                                                                                                    setState(() {
                                                                                                      radioValue = value.toString();
                                                                                                    });
                                                                                                  }),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: const EdgeInsets.symmetric(horizontal: 30),
                                                                                            child: ListTile(
                                                                                              title: const Text("GEO", style: TextStyle(color: Colors.white)),
                                                                                              leading: Radio(
                                                                                                  value: 'GEO',
                                                                                                  groupValue: radioValue,
                                                                                                  activeColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                  onChanged: (value) {
                                                                                                    setState(() {
                                                                                                      radioValue = value.toString();
                                                                                                    });
                                                                                                  }),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                              margin: const EdgeInsets.symmetric(horizontal: 30),
                                                                                              child: ListTile(
                                                                                                title: const Text("CAR/CEFIR", style: TextStyle(color: Colors.white)),
                                                                                                leading: Radio(
                                                                                                    value: 'CAR/CEFIR',
                                                                                                    groupValue: radioValue,
                                                                                                    activeColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                    onChanged: (value) {
                                                                                                      setState(() {
                                                                                                        radioValue = value.toString();
                                                                                                      });
                                                                                                    }),
                                                                                              ))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Container(
                                                                                        padding: const EdgeInsets.all(60),
                                                                                        child: ValueListenableBuilder(
                                                                                            valueListenable: statusValue,
                                                                                            builder: (BuildContext context, String value, _) {
                                                                                              return SizedBox(
                                                                                                child: DropdownButtonFormField(
                                                                                                  dropdownColor: const Color(0xFF1b263b),
                                                                                                  focusColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                  style: const TextStyle(color: Colors.white),
                                                                                                  isExpanded: true,
                                                                                                  hint: const Text(
                                                                                                    'Selecione a opção',
                                                                                                    style: TextStyle(color: Colors.white),
                                                                                                  ),
                                                                                                  decoration: InputDecoration(
                                                                                                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                    labelText: 'Status',
                                                                                                    labelStyle: const TextStyle(color: Colors.white, fontSize: 10),
                                                                                                    border: OutlineInputBorder(
                                                                                                      borderRadius: BorderRadius.circular(6),
                                                                                                      borderSide: const BorderSide(
                                                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                                                      ),
                                                                                                    ),
                                                                                                    focusedBorder: const OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                                                      ), //<-- SEE HERE
                                                                                                    ),
                                                                                                  ),
                                                                                                  value: (value.isEmpty) ? null : value,
                                                                                                  onChanged: (escolha) => statusValue.value = escolha.toString(),
                                                                                                  items: dropCategoria
                                                                                                      .map(
                                                                                                        (op) => DropdownMenuItem(
                                                                                                          value: op,
                                                                                                          child: Text(op),
                                                                                                        ),
                                                                                                      )
                                                                                                      .toList(),
                                                                                                ),
                                                                                              );
                                                                                            }),
                                                                                      ),
                                                                                    )
                                                                                  ])
                                                                                ]),
                                                                              ]),
                                                                          Container(
                                                                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 25.0),
                                                                              child: SizedBox(
                                                                                height: 40,
                                                                                width: 200,
                                                                                child: ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      final newUser = Usua(id: user.id, nome: nomeCliente.text, cpf: cpf.text, email: email.text, preco: num.parse(pre.text), servico: radioValue.toString(), status: statusValue.value, data: data.text, anotacoes: anotacoes.text, docs: user.docs);

                                                                                      if (!CPFValidator.isValid(cpf.text)) {
                                                                                        alertDialog(context, 'CPF invalido!');
                                                                                        return;
                                                                                      }

                                                                                      loadingDialog(context, 'Carregando...');

                                                                                      await authService2.updateUser(newUser);

                                                                                      Navigator.pop(context);
                                                                                      alertDialog3(
                                                                                        context,
                                                                                        'Dados editado com sucesso!',
                                                                                      );

                                                                                      setState(() {
                                                                                        nomeCliente.text = '';
                                                                                        email.text = '';
                                                                                        cpf.text = '';
                                                                                        pre.text = '';
                                                                                        data.text = '';
                                                                                        anotacoes.text = '';
                                                                                      });
                                                                                    },
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF0d1b2a)),
                                                                                    ),
                                                                                    child: const Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(Icons.update, color: Colors.white),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.all(7),
                                                                                          child: Text('Atualizar', style: TextStyle(color: Colors.white)),
                                                                                        ),
                                                                                      ],
                                                                                    )),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                            )));
                                              },
                                              child: const Icon(Icons.edit,
                                                  size: 30,
                                                  color: Colors.greenAccent))),
                                      Container(
                                          child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                            'Deseja apagar os dados do(a) cliente ${user.nome}?',
                                                            style: const TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await authService2
                                                                      .deleteUser(
                                                                          user.id);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                  'Sim',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF1b263b)),
                                                                )),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                  'Não',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF1b263b),
                                                                  ),
                                                                ))
                                                          ],
                                                        ));
                                              },
                                              child: const Icon(
                                                Icons.delete_outline,
                                                size: 30,
                                                color: Colors.redAccent,
                                              )))
                                    ])
                                  ]))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]));
        });
  }
}
