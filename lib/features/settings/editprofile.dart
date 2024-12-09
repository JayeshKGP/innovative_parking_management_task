import 'package:flutter/material.dart';
import 'package:innovative_parking_management_task/core/widgets/text_form.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 60,),
        Center(child: CircleAvatar(
          radius: 48, // Image radius
          backgroundImage: AssetImage('assets/images/person.png'),
        ),),
        SizedBox(height: 10,),
        text_form(label: 'Phone Number'),
        TextField(
          //add controller
          readOnly: true, // Makes the TextField non-selectable
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text style
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white, // White background
            prefixIcon: Icon(Icons.call, color: Colors.black), // Call icon
            hintText: '1234567890',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold, // Hint text bold
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 14), // Padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50), // Curved radius
              borderSide: BorderSide.none, // No border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50), // Curved radius for enabled state
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1), // Optional border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50), // Curved radius for focused state
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2), // Highlight on focus
            ),
          ),
        )
      ],),));
  }
}
