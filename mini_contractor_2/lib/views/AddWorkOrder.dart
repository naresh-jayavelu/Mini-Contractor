import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mini_contractor_2/controllers/AddWorkOrderController.dart';
import 'package:mini_contractor_2/models/AddWorkOrderData.dart';
import 'package:mini_contractor_2/models/Address.dart';
// import 'package:mini_contractor_2/models/WorkOrderjoin.dart';
import 'package:mini_contractor_2/views/Contractor/AddAddress.dart';


class AddWorkOrder extends StatefulWidget {
  @override
  _AddWorkOrderState createState() => _AddWorkOrderState();
}

class _AddWorkOrderState extends State<AddWorkOrder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AddWorkOrderData _workOrder;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  Uint8List? _imageBytes;
  AddWorkOrderController _AddWorkOrderController = AddWorkOrderController();
  final ImagePicker _picker = ImagePicker();
  late Map<String, String> _expertiseOptions = {};
  late Map<String, String> _jobTypeOptions = {};

  Address? address;

  @override
  void initState() {
    super.initState();
    _initializeOptions();
    _workOrder = AddWorkOrderData(
      description: '',
      estimatedAmount: '',
      status: '',
      estimatedStartDate: DateTime.now().toString(),
      estimatedEndDate: DateTime.now().add(Duration(days: 1)).toString(), isAssigned: false, isActive: false,
    );
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _startDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _endDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
  }

  Future<void> _initializeOptions() async {
    try {
      final expertiseData = await _AddWorkOrderController.fetchExpertise();
      final jobTypeData = await _AddWorkOrderController.fetchJobTypes();

      setState(() {
        _expertiseOptions = Map.fromIterable(expertiseData,
            key: (item) => item['id'] ?? '',
            value: (item) => item['value'] ?? '');
        _jobTypeOptions = Map.fromIterable(jobTypeData,
            key: (item) => item['id'] ?? '',
            value: (item) => item['value'] ?? '');
      });
    } catch (error) {
      print('Failed to initialize options: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Work Order'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: _captureImage,
                child: Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.rectangle,
                    image: _imageBytes != null
                        ? DecorationImage(
                            image: MemoryImage(_imageBytes!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageBytes == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey[400],
                        )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    _workOrder.description = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estimated Amount'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (value) {
                  setState(() {
                    _workOrder.estimatedAmount = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Expertise'),
                value: _workOrder.expertiseId,
                items: _expertiseOptions.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(_expertiseOptions[value]!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _workOrder.expertiseId = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Job Type'),
                value: _workOrder.jobTypeId,
                items: _jobTypeOptions.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(_jobTypeOptions[value]!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _workOrder.jobTypeId = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estimated Start Date'),
                controller: _startDateController,
                readOnly: true,
                onTap: () => _selectDate(context, _startDateController, true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select estimated start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estimated End Date'),
                controller: _endDateController,
                readOnly: true,
                onTap: () => _selectDate(context, _endDateController, false),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select estimated end date';
                  }
                  return null;
                },
              ),
              ElevatedButton(
  onPressed: () async {
   final selectedAddress = await Navigator.push<Address?>(
  context,
  MaterialPageRoute(
    builder: (context) => AddAddress(onSubmit: (value) { address; }),
  ),
);
if (selectedAddress != null) {
  setState(() {
    address = selectedAddress;
  });
}
  },
  child: Text('Add Address'),
),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: Text('Add Work Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageBytes = File(image.path).readAsBytesSync();
      });
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStartDate ? DateTime.now() : DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != (_workOrder.estimatedStartDate)) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        if (isStartDate) {
          _workOrder.estimatedStartDate = pickedDate.toString();
        } else {
          _workOrder.estimatedEndDate = pickedDate.toString();
        }
      });
    }
  }
Future<void> _submitForm() async {
  String? base64Image;

  if (_imageBytes != null) {
    try {
    // Decode the image from bytes
    img.Image? image = img.decodeImage(_imageBytes!);

    // Encode the image to JPEG format with reduced quality (e.g., 50%)
    List<int> compressedImage = img.encodeJpg(image!, quality: 50); // Adjust the quality as needed

    // Encode the compressed image bytes to base64
    base64Image = base64Encode(compressedImage);
  } catch (error) {
    print('Image compression error: $error');
    // Handle compression error
  }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please add an image'),
      ),
    );
    return;
  }
    if (_workOrder.expertiseId == null || _workOrder.jobTypeId == null) {
      // Show a SnackBar if either expertise or job type is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both expertise and job type'),
        ),
      );
      return;
    }



    // Check if both start date and end date are selected
    if (_workOrder.estimatedStartDate.isEmpty ||
        _workOrder.estimatedEndDate.isEmpty) {
      // Show a SnackBar if either start date or end date is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both estimated start and end dates'),
        ),
      );
      return;
    }
  if (address==null){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please address'),
        ),
      );
      // return;
      Address address=Address(
                  addressLine1:'',
                  addressLine2: '',
                  pincode: '',
                  country:  '',
                  state:   '',
                  city: '',
                  latitude: '',
                  longitude:'',
                  
                );
                _AddWorkOrderController.submitWorkOrder(_workOrder, base64Image,address,context);
    }
    else{
    _AddWorkOrderController.submitWorkOrder(_workOrder, base64Image,address!,context);
    }
    
  }
}
