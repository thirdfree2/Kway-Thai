import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/view/buffalo/update_buffalo_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBuffaloView extends StatefulWidget {
  const EditBuffaloView({super.key});

  @override
  State<EditBuffaloView> createState() => _EditBuffaloViewState();
}

class _EditBuffaloViewState extends State<EditBuffaloView> {
  late TextEditingController _nameController = TextEditingController();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();
    final buffalo = Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
    _nameController = TextEditingController(text: buffalo?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextFormField(
            controller: _nameController,
            labelText: 'ชื่อ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกข้อมูล';
              }
              return null;
            },
          ),
          // FamilyForm(
          //     nameController: nameController,
          //     farmController: farmController,
          //     buffaloHeadText: buffaloHeadText,
          //     buffaloNameText: buffaloNameText)
        ],
      ),
    );
  }
}
