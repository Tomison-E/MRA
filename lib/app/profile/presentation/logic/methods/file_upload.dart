import 'dart:typed_data';

import 'package:mra/src/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';

mixin FileUpload {
  bool isValidFileSize(Uint8List size, BuildContext context) {
    if (size.lengthInBytes <= 2097152) {
      return true;
    } else {
      Toast.info("File size must not be more than 2MB", context);
      return false;
    }
  }
}
