import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

class PickedUploadFile {
  const PickedUploadFile({
    required this.name,
    required this.extension,
    this.file,
    this.bytes,
  });

  final String name;
  final String? extension;
  final File? file;
  final Uint8List? bytes;
}

class FileUploadService {
  FileUploadService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<PickedUploadFile?> pickFile(String type) async {
    final allowedExtensions = type == 'document'
        ? const ['doc', 'docx', 'pdf', 'txt', 'csv', 'xlsx']
        : null;
    final fileType = switch (type) {
      'image' => FileType.image,
      'video' => FileType.video,
      'document' => FileType.custom,
      _ => FileType.any,
    };

    final result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: allowedExtensions,
      withData: kIsWeb,
    );
    if (result == null || result.files.isEmpty) return null;

    final selected = result.files.single;
    return PickedUploadFile(
      name: selected.name,
      extension: selected.extension,
      file: kIsWeb || selected.path == null ? null : File(selected.path!),
      bytes: selected.bytes,
    );
  }

  Future<String> upload(PickedUploadFile selected, String type) async {
    if (!ApiConfig.hasCloudinaryConfig) {
      throw StateError(
        'Cloud upload is not configured. Pass CLOUDINARY_CLOUD_NAME and '
        'CLOUDINARY_UPLOAD_PRESET with --dart-define for release builds.',
      );
    }

    final resourceType = switch (type) {
      'image' => 'image',
      'video' => 'video',
      _ => 'raw',
    };
    final uploadUrl =
        'https://api.cloudinary.com/v1_1/${ApiConfig.cloudinaryCloudName}/$resourceType/upload';

    final multipartFile = selected.bytes != null
        ? MultipartFile.fromBytes(selected.bytes!, filename: selected.name)
        : await MultipartFile.fromFile(
            selected.file!.path,
            filename: selected.name,
          );

    final formData = FormData.fromMap({
      'file': multipartFile,
      'upload_preset': ApiConfig.cloudinaryUploadPreset,
    });
    final response = await _dio.post<Map<String, dynamic>>(
      uploadUrl,
      data: formData,
    );
    final secureUrl = response.data?['secure_url'] as String?;
    if (secureUrl == null || secureUrl.isEmpty) {
      throw StateError('Cloud upload did not return a secure URL.');
    }
    return secureUrl;
  }
}
