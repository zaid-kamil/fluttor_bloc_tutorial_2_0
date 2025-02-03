import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/bloc/list_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/bloc/upload_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  Future<void> uploadImageToCloud() async {
    final imagePicker = ImagePicker();
    XFile? image;
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (kIsWeb) {
      final imageBytes = await image.readAsBytes();
      if (mounted) {
        context
            .read<UploadBloc>()
            .add(UploadImageWebEvent(image.name, imageBytes));
      }
    } else {
      if (mounted) {
        context.read<UploadBloc>().add(UploadImageEvent(image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: BlocConsumer<UploadBloc, UploadState>(
        listener: (context, state) {
          if (state is UploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image uploaded successfully'),
              ),
            );
            // reload images
            context.read<ListBloc>().add(LoadListEvent());
          }
          if (state is UploadFailure) {
            debugPrint(state.message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to upload image ${state.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UploadLoading) {
            return _loadingWidget();
          } else if (state is UploadSuccess) {
            return _successWidget();
          } else if (state is UploadFailure) {
            return _failureWidget();
          }
          return _initialWidget();
        },
      ),
    );
  }

  Widget _initialWidget() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade900,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: uploadImageToCloud,
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.upload_file, size: 100),
                SizedBox(height: 10),
                const Text('Upload Image'),
                SizedBox(height: 10),
                const Text(
                  '*.jpg, *.jpeg, *.png',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade900),
        strokeCap: StrokeCap.round,
        strokeAlign: BorderSide.strokeAlignCenter,
        strokeWidth: 5,
      ),
    );
  }

  Widget _successWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, size: 100, color: Colors.green),
          SizedBox(height: 10),
          const Text('Image uploaded successfully'),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              context.read<UploadBloc>().add(ResetUploadEvent());
            },
            child: const Text('Upload another image'),
          ),
        ],
      ),
    );
  }

  Widget _failureWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, size: 100, color: Colors.red),
          SizedBox(height: 10),
          const Text('Failed to upload image'),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              context.read<UploadBloc>().add(ResetUploadEvent());
            },
            child: const Text('Upload another image'),
          ),
        ],
      ),
    );
  }
}
