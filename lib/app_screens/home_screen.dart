import 'dart:io';

import 'package:contact_app/app_data/app_animations.dart';
import 'package:contact_app/app_data/app_colors.dart';
import 'package:contact_app/app_data/app_images.dart';
import 'package:contact_app/app_data/contact.dart';
import 'package:contact_app/app_widget/app_text_field.dart';
import 'package:contact_app/app_widget/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final List<Contact> contactList = [
    Contact("Messi", AppImages.messi, "01205555656", "messi@gmail.com"),
    Contact("ElBalf", AppImages.elbalf, "01208565656", "elbalf@gmail.com"),
    Contact("Messi1", AppImages.messi1, "01208545656", "messi1@gmail.com"),
    Contact("Route", AppImages.route, "01861555656", "route@gmail.com"),
    Contact("elbalf23", AppImages.elbalf, "01205553686", "elbalf2@gmail.com")
  ];
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool _isValidEmail(String email){
    return RegExp(r'^[\w\.\-]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(email);
  }

  bool _isValidPhone(String phone){
    return RegExp(r'^(\+20|0)?1[0125]\d{8}$').hasMatch(phone);
  }

  void _showError(String msg){
    showDialog(context: context,
        builder: (_)=> AlertDialog(
          content: Text(msg,style: TextStyle(color: AppColors.gold),),
          backgroundColor: AppColors.darkBlue,
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: const Text("OK",style: TextStyle(color: AppColors.gold),)
            )
          ],
        ));
  }
  String pickImage = AppImages.elbalf;

  Future<void> _pickImage(StateSetter sheetSetState) async {
    final x = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(x != null) sheetSetState(() => pickImage= x.path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        leadingWidth: 180,
        backgroundColor: Colors.transparent,
        leading: Image.asset(AppImages.routeLogo),
      ),
      body: contactList.isEmpty
          ? Center(
              child: Column(
                children: [
                  Lottie.asset(AppAnimations.emptyList),
                  Text(
                    "There is No Contacts Added Here",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight(500),
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 300,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
              ),
              padding: EdgeInsetsGeometry.all(15),
              itemCount: contactList.length ,
              itemBuilder: (context, index) {
                final c = contactList[index];
                return ContactCard(
                    contact: c, onDelete: () => _deleteAt(index));
              }
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(contactList.isNotEmpty)
            FloatingActionButton(
              onPressed: () => _deleteAt(contactList.length-1),
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, size: 30,color: AppColors.white,),
            ),
          SizedBox(height: 12,),
          if(contactList.length < 6)
            FloatingActionButton(
              onPressed: _showAddSheet,
              backgroundColor: AppColors.gold,
              child: Icon(Icons.add, size: 30),
            ),
        ],
      ),
    );
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkBlue,
      builder: (context) {
        return StatefulBuilder(builder: (context, sheetSetState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              left: 16,
              right: 16,
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: SizedBox(
              height: 550,
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _pickImage(sheetSetState),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(25),
                              border: BoxBorder.all(color: AppColors.gold),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: pickImage == AppImages.elbalf
                            ?Lottie.asset(AppAnimations.imagePicker)
                            : Image.file(File(pickImage),fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          spacing: 15,
                          children: [
                            Text(
                              "User Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight(500),
                                color: AppColors.gold,
                              ),
                            ),
                            Container(height: 1, color: AppColors.gold),
                            Text(
                              "example@email.com",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight(500),
                                color: AppColors.gold,
                              ),
                            ),
                            Container(height: 1, color: AppColors.gold),
                            Text(
                              "+200000000000",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight(500),
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppTextField(text: "Enter User Name ", controller: nameCtrl),
                  AppTextField(
                      text: "Enter User Email ", controller: emailCtrl),
                  AppTextField(
                      text: "Enter User Phone ", controller: phoneCtrl),
                  ElevatedButton(
                    onPressed: () {
                      if (contactList.length >= 6) return;
                      final name = nameCtrl.text.trim();
                      final email = emailCtrl.text.trim();
                      final phone = phoneCtrl.text.trim();

                      if (name.isEmpty || email.isEmpty || phone.isEmpty) {
                        _showError("Please Fill in all Fields");
                        return;
                      }
                      if (!_isValidEmail(email)) {
                        _showError("Invalid Email Address");
                        return;
                      }
                      if (!_isValidPhone(phone)) {
                        _showError("Invalid Phone Number");
                        return;
                      }
                      setState(() {
                        contactList.add(
                          Contact(
                            name,
                            pickImage,
                            phone,
                            email,
                          ),
                        );
                        pickImage=AppImages.elbalf;
                      });
                      {
                        nameCtrl.clear();
                        emailCtrl.clear();
                        phoneCtrl.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      fixedSize: Size(390, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),
                    ),
                    child: Text(
                      "Enter user",
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight(400),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        );
      },
    );
  }
  void _deleteAt(int index){
    setState(()=> contactList.removeAt(index));
  }

}
