import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/utils/appbar.dart';
import 'package:fideos_mobile_app/utils/seperator.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(Get.width, 50), child: appbar),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
             
              //  Select address title
              Center(
                child: Container(
                  // width: 250,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text('Select from Your Saved Addresses'),
                ),
              ),
          
              // Adding some space
              Space.show(height: 10),
          
              // Divider
              Divider(color: AppColor.black.withOpacity(0.09)),

              Space.show(height: 10),

              // Current location
              currentLocation,

              // Adding some space 
              Space.show(height: 20),

              // Seperator
              Seperator(text: 'Saved Addresses', horizontalPadding: 0).show(),

            ],
          ),
        ),
      ),
    );
  }

  // Appbar
  Widget get appbar => CommonAppBar(
        leading: const Icon(Feather.arrow_left),
        title: const Text('Select Address', style: TextStyle(fontSize: 20)),
        actions: Space.show(),
);

  // Current loaction
  Widget get currentLocation => Container(
    width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.primary, width: 2)
      ),
      child:
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(child: Text("Current Location", style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600))),
          ),
);
}
