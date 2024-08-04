import 'package:flutter/material.dart';

class RegisterFarmField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? dropdownValue;
  final void Function(String?)? onDropdownChanged;
  final String? Function(String?)? validator;
  final String? hintText;

  const RegisterFarmField({super.key, 
    required this.label,
    required this.controller,
    this.isDropdown = false,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.validator,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: isDropdown
                ? DropdownButtonFormField<String>(
                    value: dropdownValue,
                    items: dropdownItems!.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: onDropdownChanged,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: validator,
                  )
                : TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: hintText,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
