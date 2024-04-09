import 'package:get/get.dart';

import '../../../utils/helper/firestoreHelper.dart';

class StreamController extends GetxController {
  get streamdata async {
    Stream? datastream;
    datastream = await FirestoreHelper.firestoreHelper.fetchtask();
    return datastream;
  }
}
