import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedDropScreen extends StatefulWidget {
  const RedDropScreen({super.key});

  @override
  State<RedDropScreen> createState() => _RedDropScreenState();
}

class _RedDropScreenState extends State<RedDropScreen> {
  final notecontroller = TextEditingController();
  String? selectedBloodGroup;
  String? selectedLocation;
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final List<String> locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Miami',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RED DROP",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.onSecondaryContainer,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0).r,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "Find Donar",

                            style: TextStyle(
                              fontSize: 18.0.sp,
                              // color: colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "Select Blood Group",
                            style: TextStyle(
                              fontSize: 17.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedBloodGroup,
                          hint: Text(
                            "Choose Blood Group",
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          isExpanded: true,
                          items:
                              bloodGroups.map((String group) {
                                return DropdownMenuItem<String>(
                                  value: group,
                                  child: Text(group),
                                );
                              }).toList(),
                          dropdownColor: colorScheme.secondaryContainer,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedBloodGroup = newValue;
                            });
                          },
                        ),

                        SizedBox(height: 20.h),

                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "Select Location",
                            style: TextStyle(
                              fontSize: 17.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedLocation,

                          hint: Text(
                            "Choose Location",
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          isExpanded: true,
                          items:
                              locations.map((String location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(location),
                                );
                              }).toList(),
                          dropdownColor: colorScheme.secondaryContainer,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocation = newValue;
                            });
                          },
                        ),
                        TextFormField(
                          controller: notecontroller,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Write a note",
                            hintStyle: TextStyle(
                              color: colorScheme.onSecondary,
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 8.0,
                                ).r,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0).r,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0).r,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0).r,
                            ),
                          ),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Click Here to Add Reciept",
                          style: TextStyle(
                            fontSize: 17.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.secondary,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Upload",
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Click Here to Request for blood",
                          style: TextStyle(
                            fontSize: 17.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.secondary,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Request Blood",
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.0.h),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood Requests",
                          style: TextStyle(
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(10).r,
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "URGENT",
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
