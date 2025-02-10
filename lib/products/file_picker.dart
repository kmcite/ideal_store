import 'package:file_picker/file_picker.dart';
import 'package:manager/manager.dart';

Future<Uint8List?> filePicker() async {
  FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
    dialogTitle: 'Select Image for Product',
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'png',
    ],
  );
  if (filePickerResult != null) {
    return filePickerResult.files.first.bytes;
  } else {
    return null;
  }
}
