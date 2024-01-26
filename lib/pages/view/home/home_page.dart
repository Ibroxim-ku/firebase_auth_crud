import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contac_app/pages/models/car_model.dart';
import 'package:contac_app/pages/services/auth_service.dart';
import 'package:contac_app/pages/services/cloud_firestore.dart';
import 'package:contac_app/pages/view/auth/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
  TextEditingController nameC0n = TextEditingController();
  TextEditingController colorC0n = TextEditingController();
  TextEditingController costC0n = TextEditingController();
  TextEditingController speedC0n = TextEditingController();
  TextEditingController madeYearC0n = TextEditingController();
  TextEditingController typeC0n = TextEditingController();

  User? user;
  Future<void> read() async {
    isLoading = false;
    setState(() {});
    list = await CFSService.readAllData(collectionPath: "car");
    isLoading = true;
    setState(() {});
  }

  Future<void> create() async {
    await CFSService.createCollection(
        collectionPath: "car",
        data: {"memory": "128", "model": "iPhone 9", "name": "qwerty"});
  }

  @override
  void initState() {
    if (widget.user != null) {
      user = widget.user;
    }
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIREBASE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.logOutAcc().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoDialogRoute(
                        builder: (context) => const LoginPage(),
                        context: context),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.yellowAccent,
                  child: ListTile(
                    title: Text(
                      list[index].data()["name"] ?? "no name",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            nameC0n.text = list[index]["name"];
                            colorC0n.text = list[index]["color"];
                            costC0n.text = list[index]["cost"];
                            speedC0n.text = list[index]["speed"];
                            madeYearC0n.text = list[index]["madeYear"];
                            typeC0n.text = list[index]["type"];
                            _editData(index);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        IconButton(
                          onPressed: () async {
                            await CFSService.delete(
                                collectionPath: "car", id: list[index].id);
                            await read();
                          },
                          icon: const Icon(CupertinoIcons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showDisplay();
          // Car car = Car(
          //   name: "Gentra",
          //   color: "white",
          //   cost: "14000",
          //   speed: "220",
          //   madeYear: "2019",
          //   type: "own",
          // );

          // await CFSService.createCollection(
          //     collectionPath: "car", data: car.toJson());
          // await read();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDisplay() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "ADD CAR MODEL",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameC0n,
                  decoration: const InputDecoration(
                    hintText: "NAME",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: colorC0n,
                  decoration: const InputDecoration(
                    hintText: "COLOR",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: costC0n,
                  decoration: const InputDecoration(
                    hintText: "COST",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: speedC0n,
                  decoration: const InputDecoration(
                    hintText: "SPEED",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: madeYearC0n,
                  decoration: const InputDecoration(
                    hintText: "MADEYEAR",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: typeC0n,
                  decoration: const InputDecoration(
                    hintText: "TYPE",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Car car = Car(
                  name: nameC0n.text,
                  color: colorC0n.text,
                  cost: costC0n.text,
                  speed: speedC0n.text,
                  madeYear: madeYearC0n.text,
                  type: typeC0n.text,
                );

                await CFSService.createCollection(
                    collectionPath: "car", data: car.toJson());
                await read().then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _editData(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "ADD CAR MODEL",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameC0n,
                  decoration: const InputDecoration(
                    hintText: "NAME",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: colorC0n,
                  decoration: const InputDecoration(
                    hintText: "COLOR",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: costC0n,
                  decoration: const InputDecoration(
                    hintText: "COST",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: speedC0n,
                  decoration: const InputDecoration(
                    hintText: "SPEED",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: madeYearC0n,
                  decoration: const InputDecoration(
                    hintText: "MADEYEAR",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: typeC0n,
                  decoration: const InputDecoration(
                    hintText: "TYPE",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Car car = Car(
                  name: nameC0n.text,
                  color: colorC0n.text,
                  cost: costC0n.text,
                  speed: speedC0n.text,
                  madeYear: madeYearC0n.text,
                  type: typeC0n.text,
                );
                await CFSService.update(
                    collectionPath: "car",
                    data: car.toJson(),
                    id: list[index].id);
                await read().then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
