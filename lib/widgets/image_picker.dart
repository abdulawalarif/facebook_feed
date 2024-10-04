import 'package:image_picker/image_picker.dart';

class ImagePickerClass{
  static selectImageFromGallery() async {

    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  static selectImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}