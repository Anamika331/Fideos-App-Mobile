import 'package:fideos_mobile_app/controllers/address.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/utils/appbar.dart';
import 'package:fideos_mobile_app/utils/outline_button.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:fideos_mobile_app/utils/text.form.field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class EditAddressScreen extends StatefulWidget {
   const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
 // Importing controller 
    final _addressController = Get.put(AddressController());

    @override
  void initState() {
    
    super.initState();
    _addressController.fullAddressController.text  = 'DN-24, Saltlake, Sector 5, Kolkata, India';
    _addressController.cityController.text = 'Kolkata';
    _addressController.stateController.text = 'West Bengal';
    _addressController.pincodeController.text = '700009';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(Get.width, 50), child: appBar),
      body: Column(
          children: [
             // Editing address tile
              Center(
                child: Container(
                  // width: 250,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text('Editing Address - DN-24, Saltlake...', style: TextStyle(overflow: TextOverflow.ellipsis),),
                ),
              ),

              // Adding some space 
              Space.show(height: 10),

              // Diivider
              Divider(color: AppColor.black.withOpacity(0.09)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Full address 
                    CommonTextFormField(controller: _addressController.fullAddressController, hint: 'Full Address').show(),

                    // Adding some space 
                    Space.show(height: 10),
                
                    // City 
                    CommonTextFormField(controller: _addressController.cityController, hint: 'City').show(),

                    // Adding some space 
                    Space.show(height: 10),

                    // State 
                    CommonTextFormField(controller: _addressController.stateController, hint: 'State').show(),

                    // Adding some space 
                    Space.show(height: 10),
                
                    // Pincode
                    CommonTextFormField(controller: _addressController.pincodeController, hint: 'Pincode').show(),

                    // Adding some space
                    Space.show(height: 20),

                    const CommonOutlineButton(text: 'Save Address')

                  ],
                ),
              )
            
          ],
      ),);
  }

  // Appbar 
  Widget get appBar  => CommonAppBar(
    leading: const Icon(Feather.arrow_left),
    title: const Text("Edit Address"),
    actions: Space.show(),
  );
}