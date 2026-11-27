import 'dart:io';

import 'package:contact_app/app_data/app_colors.dart';
import 'package:contact_app/app_data/app_images.dart';
import 'package:contact_app/app_data/contact.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  ContactCard({
    super.key,
    required this.contact,
    required this.onDelete
});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: AlignmentGeometry.topCenter,
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: contact.image.startsWith("assets/")
              ?Image.asset(contact.image,
                width: 200,
                fit: BoxFit.fill,
              )
              :Image.file(File(contact.image),
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0,right: 130),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(8)

                ),
                child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(contact.name,
                        style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight(500)
                                      ),
                        maxLines: 1,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 205.0,left: 5),
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.email,color: AppColors.darkBlue),
                  Text(contact.email,style: TextStyle(fontSize: 12,fontWeight: FontWeight(500),color: AppColors.darkBlue),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 225.0,left: 5),
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.phone_in_talk_rounded,color: AppColors.darkBlue),
                  Text(contact.phone,style: TextStyle(fontSize: 15,fontWeight: FontWeight(500),color: AppColors.darkBlue),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: ElevatedButton(onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 30),
                    backgroundColor: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Icon(Icons.delete,color: AppColors.white,),
                      Text("Delete",style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight(500)
                      ),),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
