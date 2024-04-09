import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/helper/firestoreHelper.dart';

class detail extends StatelessWidget {
  detail({super.key});

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Task Details"),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "${data[0]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "${data[1]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      FirestoreHelper.firestoreHelper.deteletask(id: data[2]);
                      Get.back();
                    },
                    child: Container(
                      height: Get.width * 0.2,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text("Delete")),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Title",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (val) {
                                      data[0] = val;
                                    },
                                    decoration: InputDecoration(
                                      hintText: data[0],
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (val) {
                                      data[1] = val;
                                    },
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: data[1],
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
                                      Map<String, dynamic> newdata = {
                                        "id": "${data[2]}",
                                        "title": "${data[0]}",
                                        "task": "${data[1]}",
                                      };
                                      await FirestoreHelper.firestoreHelper
                                          .updatetask(
                                              newdata: newdata, id: data[2]);
                                    },
                                    child: Container(
                                      height: Get.height * 0.08,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                    child: Container(
                      height: Get.width * 0.2,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text("Update")),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
