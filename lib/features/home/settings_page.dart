import 'package:flutter/material.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';
import 'package:innovative_parking_management_task/features/settings/editprofile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, String>> items = [
    {'label': 'Edit Profile', 'image': 'assets/images/editprofile.png'},
    {'label': 'App Language', 'image': 'assets/images/applanguage.png'},
    {'label': 'MyWallet', 'image': 'assets/images/mywallet.png'},
    {'label': 'Notifications', 'image': 'assets/images/notification.png'},
    {'label': 'Dark Mode', 'image': 'assets/images/darkmode.png'},
    {'label': 'Contact & Help', 'image': 'assets/images/contact&help.png'},
  ];

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60,),
        Center(child: CircleAvatar(
          radius: 48, // Image radius
          backgroundImage: AssetImage('assets/images/person.png'),
        ),),
        Text('Darshan Madhu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Plus Jakarta Sans'),),
        Text('darshanmadhublr@gmail.com', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff878698)),),
        SizedBox(height: 15,),

        Container(height: 500, child:
        ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14), // Rounded corners
                ),
                elevation: 0,
                child: GestureDetector(onTap: (){
                  switch (index){
                    case 0:
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfile()),
                      );
                      break;
                  }
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          items[index]['image']!, // Use the image path from the list
                          width: 40, // Set width for the image
                          height: 40, // Set height for the image
                        ),
                      ),
                      Text(
                        items[index]['label']!, // Use the label from the list
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      if (index!=4) Icon(Icons.chevron_right),
                      if (index==4)Text(isDark ? 'On' : 'Off', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: (isDark) ? AppColors.primaryColor : Color(0xff9f9fb5), fontFamily: 'Plus Jakarta Sans'),),
                      if (index==4)Switch(
                        value: isDark,
                        onChanged: (value) {
                          setState(() {
                            isDark = value;
                          });
                        },
                        activeColor: AppColors.primaryColor, // Customize active color
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),)
              ),
            );
          },
        ),)


      ],);
  }
}

