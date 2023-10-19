import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFile({bool onlySvg = false}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: onlySvg ? FileType.custom : FileType.image,
      allowedExtensions: onlySvg ? ["svg", "SVG"] : null);
  if (result != null) {
    return File(result.files.single.path!);
  } else {
    return null;
  }
}
