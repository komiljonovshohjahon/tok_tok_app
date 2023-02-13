import 'package:file_picker/file_picker.dart';

class PickerClient {
  final FilePicker _picker = FilePicker.platform;

  Future<PlatformFile?> pickImage() async {
    final FilePickerResult? result = await _picker.pickFiles(
      withData: true,
      type: FileType.custom,
      onFileLoading: (p0) {
        print("Picking file: $p0");
      },
      allowedExtensions: ["jpg", "png", 'mp4'],
    );
    return result?.files.first;
  }
}
