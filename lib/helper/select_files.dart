import 'package:file_picker/file_picker.dart';

Future<List<PlatformFile>?>? selectPlatformFiles() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.any, allowMultiple: true);

  if (result != null) {
    return result.files;
  }

  return null;
}
