import 'dart:io';

import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stroke_text/stroke_text.dart';

class MainRegisterAward extends StatefulWidget {
  const MainRegisterAward({super.key});

  @override
  State<MainRegisterAward> createState() => _MainRegisterAwardState();
}

class _MainRegisterAwardState extends State<MainRegisterAward> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: const Column(
              children: [
                SizedBox(height: 30),
                BackButtonRow(),
                TitleText(),
                SizedBox(height: 20),
                AwardTextFieldRow(
                  label1: 'รางวัล',
                  label2: 'อันดับ',
                  width1: 80,
                  width2: 80,
                ),
                SizedBox(height: 40),
                AwardTextFieldRow(
                  label1: 'ประเภท/รุ่น',
                  label2: 'เพศ',
                  width1: 80,
                  width2: 80,
                ),
                SizedBox(height: 40),
                AwardTextFieldRow(
                  label1: 'ความสูง',
                  label2: '',
                  width1: 80,
                  width2: 0,
                ),
                SizedBox(height: 40),
                AwardTextFieldRow(
                  label1: 'งานประกวด',
                  label2: '',
                  width1: 180,
                  width2: 0,
                ),
                SizedBox(height: 20),
                ImageUploader(),
                SizedBox(height: 20),
                SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButtonRow extends StatelessWidget {
  const BackButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, size: 30),
        ),
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StrokeText(
        text: "ลงทะเบียนรางวัลประกวด",
        textStyle: TextStyle(
          fontSize: ScreenUtils.calculateFontSize(context, 24),
          color: Colors.red,
        ),
        strokeColor: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}

class AwardTextFieldRow extends StatelessWidget {
  final String label1;
  final String label2;
  final double width1;
  final double width2;

  const AwardTextFieldRow({
    super.key,
    required this.label1,
    required this.label2,
    required this.width1,
    required this.width2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label1,
          style: TextStyle(
            color: Colors.red,
            fontSize: ScreenUtils.calculateFontSize(context, 16),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: width1,
          height: 30,
          child: TextFormField(
            style: TextStyle(
              fontSize: ScreenUtils.calculateFontSize(context, 10),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.yellow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        if (label2.isNotEmpty) ...[
          const SizedBox(width: 20),
          Text(
            label2,
            style: TextStyle(
              color: Colors.red,
              fontSize: ScreenUtils.calculateFontSize(context, 16),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: width2,
            height: 30,
            child: TextFormField(
              style: TextStyle(
                fontSize: ScreenUtils.calculateFontSize(context, 10),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  color: Colors.white),
              child: _selectedImage == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 30),
                        Text('เพิ่มรูปภาพ')
                      ],
                    )
                  : Image.file(_selectedImage!, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
      ),
      onPressed: () {},
      child: const Text(
        'ตกลง >>>',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
