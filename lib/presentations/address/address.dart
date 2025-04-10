import 'package:fideos_mobile_app/controllers/address.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/utils/appbar.dart';
import 'package:fideos_mobile_app/utils/outline_button.dart';
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
final _addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomAppBar,
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
              const CommonOutlineButton(text: 'Current Loaction'),

              // Adding some space 
              Space.show(height: 20),

              // Seperator
              Seperator(text: 'Saved Addresses', horizontalPadding: 0).show(),

              // Adding some space 
              Space.show(height: 10),

              // Address
              addresses,

              // Adding some space
              Space.show(height: 20),

              // Add address button  
              const CommonOutlineButton(text: 'Add Address')
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

 

  // Address list 
  Widget get addresses => Column(children: [
    ...List.generate(2, (index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          _addressController.selectedAddress.value = index;

        },
        child: Obx(() => Container(
        width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: _addressController.selectedAddress.value == index ? AppColor.primary  : AppColor.black.withOpacity(0.09),
              width: _addressController.selectedAddress.value == index ? 2 : 1
              )
          ),
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Name
                  const Text('Anamika Jha', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

                  // Phone number
                  const Text('+918697604919', style: TextStyle(fontWeight: FontWeight.w500)),

                  // Address
                  Text('DN-24, Saltlake, Sector 5, Kolkata, India', style: TextStyle(color: AppColor.black.withOpacity(0.3)),),

                  Text('Matrix Tower, 10th Floor', style: TextStyle(color: AppColor.black.withOpacity(0.3)),),

                  Text('West Bengal, Kolkata, 700009', style: TextStyle(color: AppColor.black.withOpacity(0.3)),)
                ],),

                // Edit icon
                const Image(image: AssetImage('assets/address_edit.png'), height: 20,)
              ],
            ),
          ),
        )),
      ),
    ))
  ],
);

  // Bottom app bar for proceed to order 
  Widget get bottomAppBar => BottomAppBar(
    height: 50,
    color: AppColor.primary,
    child:  Center(child: Text('Proceed to Order', style: TextStyle(color: AppColor.white, fontSize: 16),)),
);

}
