import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{

  // Selected address index
  RxInt selectedAddress = 0.obs;

  // Full address controller 
  final fullAddressController =TextEditingController();

  // City controller 
  final cityController =  TextEditingController();

  // State controller 
  final stateController =  TextEditingController();

  // Pin code controller 
  final pincodeController = TextEditingController();



}