// import 'dart:io' show File, Platform;
// import 'package:path/path.dart' as path;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:reptask/utils/custom_dialog.dart';
// import 'package:reptask/utils/generate_image_url.dart';

// class FilePickingView extends StatefulWidget {
//   const FilePickingView({Key? key}) : super(key: key);

//   @override
//   State<FilePickingView> createState() => _FilePickingViewState();
// }

// class _FilePickingViewState extends State<FilePickingView> {
//   bool _isFileSelected = false;

//   Future<void> _selectFile() async {
//     // if (_onAddPhotoClicked(context) == 1) {
//     await _onAddPhotoClicked(context);
//     final ImagePicker _picker = ImagePicker();

//     // Get the picked image
//     XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (image != null) {
//       String fileExtension = path.extension(image.path);
//       // final result = await FilePicker.platform.pickFiles();

//       //Changes started
//       GenerateImageUrl generateImageUrl = GenerateImageUrl();
//       await generateImageUrl.call(fileExtension);
//     }
//   }

//   void _deselectFile() {
//     setState(() {
//       _isFileSelected = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             _isFileSelected
//                 ? 'You selected a file. Click the button below to remove file'
//                 : 'Click the button below to select a file.',
//           ),
//           ElevatedButton(
//             onPressed: _isFileSelected ? _deselectFile : _selectFile,
//             child: Text(_isFileSelected ? 'Deselect File' : 'Select File'),
//           )
//         ],
//       ),
//     );
//   }
// }

// Future _onAddPhotoClicked(context) async {
//   Permission permission;
//   if (Platform.isIOS) {
//     permission = Permission.photos;
//   } else {
//     permission = Permission.storage;
//   }

//   PermissionStatus permissionStatus = await permission.status;

//   debugPrint(permissionStatus.toString());

//   if (permissionStatus == PermissionStatus.restricted) {
//     _showOpenAppSettingsDialog(context);

//     permissionStatus = await permission.status;

//     if (permissionStatus != PermissionStatus.granted) {
//       //Only continue if permission granted
//       return 1;
//     }
//   }

//   if (permissionStatus == PermissionStatus.permanentlyDenied) {
//     _showOpenAppSettingsDialog(context);

//     permissionStatus = await permission.status;

//     if (permissionStatus != PermissionStatus.granted) {
//       //Only continue if permission granted

//       return 1;
//     }
//   }

//   // if (permissionStatus == PermissionStatus.permanentlyDenied) {
//   //   permissionStatus = await permission.request();

//   //   if (permissionStatus != PermissionStatus.granted) {
//   //     //Only continue if permission granted
//   //     return 1;
//   //   }
//   // }

//   if (permissionStatus == PermissionStatus.denied) {
//     if (Platform.isIOS) {
//       _showOpenAppSettingsDialog(context);
//     } else {
//       permissionStatus = await permission.request();
//     }

//     if (permissionStatus != PermissionStatus.granted) {
//       //Only continue if permission granted
//       return 1;
//     }
//   }

//   if (permissionStatus == PermissionStatus.granted) {
//     // print('Permission granted');
//     // Create an instance of ImagePicker
//     final ImagePicker _picker = ImagePicker();

//     // Get the picked image
//     XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     return 1;
//   }
// }

// _showOpenAppSettingsDialog(context) {
//   return CustomDialog.show(
//     context,
//     'Permission needed',
//     'Photos permission is needed to select photos',
//     'Open settings',
//     openAppSettings,
//   );
// }
