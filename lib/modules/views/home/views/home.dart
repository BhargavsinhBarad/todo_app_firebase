import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_app_firebase/modules/utils/helper/firestoreHelper.dart';
import 'package:todo_app_firebase/modules/views/details/views/detail.dart';
import 'package:todo_app_firebase/modules/views/home/controller/streamcontroller.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? title;

  String? Task;
  Stream? datastream;
  streamdata() async {
    datastream = await FirestoreHelper.firestoreHelper.fetchtask();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamdata();
  }

  StreamController streamController = Get.put(StreamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("TODO"),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Get.bottomSheet(
            Container(
              height: Get.height * 0.7,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "TODO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Title",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      TextFormField(
                        onChanged: (val) {
                          title = val;
                        },
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Task",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      TextFormField(
                        onChanged: (val) {
                          Task = val;
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String id = randomAlphaNumeric(10);
                          Map<String, dynamic> data = {
                            "id": "$id",
                            "title": "$title",
                            "task": "$Task",
                          };
                          await FirestoreHelper.firestoreHelper
                              .addtask(data: data, id: id);
                          Get.back();
                        },
                        child: Container(
                          height: Get.height * 0.08,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<StreamController>(
        builder: (ctx) => StreamBuilder(
          stream: datastream,
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx, i) {
                  DocumentSnapshot ds = snapshot.data.docs[i];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          detail(),
                          arguments: [
                            ds['title'],
                            ds['task'],
                            ds['id'],
                          ],
                        );
                      },
                      child: Container(
                        height: 180,
                        width: Get.height,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${ds['title']}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text("${ds['task']}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
