

import 'package:fint/core/constants/exports.dart';

class PetownerInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final IconData prefixIcon;

  const PetownerInputField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).r,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.black),
          hint: Text(
            hintText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0).r,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0).r,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0).r,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}

class PetInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;

  const PetInputField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).r,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hint: Text(
            hintText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0).r,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0).r,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0).r,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
