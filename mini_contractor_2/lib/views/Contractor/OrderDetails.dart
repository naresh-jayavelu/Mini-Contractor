import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/workOrderController.dart';
import 'package:mini_contractor_2/models/WorkOrderjoin.dart';

class OrderDetail extends StatefulWidget {
  final String workOrderId;

  OrderDetail({Key? key, required this.workOrderId}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late Future<WorkOrderJoin> workOrderJoin;
  final WorkOrderController _workOrderController = WorkOrderController();

  @override
  void initState() {
    super.initState();
    workOrderJoin = _workOrderController.fetchworkorderdetails(widget.workOrderId, context);
    print(workOrderJoin);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WorkOrderJoin>(
      future: workOrderJoin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          WorkOrderJoin order = snapshot.data!;
          String base64Image = order.document.file;

          try {
            Uint8List bytes = base64Decode(base64Image);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Details'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.description}',
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Image.memory(
                          bytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Job Type: ${order.jobTypeId.jobTypeName}',
                        style: TextStyle(fontSize: 15), // Set font size to 15
                      ),
                      Text(
                        'Description: ${order.description}',
                        style: TextStyle(fontSize: 15), // Set font size to 15
                      ),
                      Text(
                        'Address: ${order.addressId.addressLine1} ${order.addressId.addressLine2} ${order.addressId.city} ${order.addressId.state} ${order.addressId.pincode}',
                        style: TextStyle(fontSize: 15), // Set font size to 15
                      ),
                      if (order.addressId.latitude != '' && order.addressId.longitude != '')
                        GestureDetector(
                          onTap: () {
                            _workOrderController.launchMaps(order.addressId.latitude, order.addressId.longitude, context);
                          },
                          child: Row(
                            children: [
                              Text('Location', style: TextStyle(color: Colors.blue)),
                              Icon(Icons.location_on, color: Colors.blue), // Add the location icon at the end
                            ],
                          ),
                        ),
                      Text(
                        'Estimated Start Date: ${order.estimatedStartDate.toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 15), // Set font size to 15
                      ),
                      // Text(
                      //   'Estimated Amount: ${order.estimatedEndDate}',
                      //   style: TextStyle(fontSize: 15), // Set font size to 15
                      // ),
                      Text(
                        'Estimated Amount: ${order.estimatedAmount}',
                        style: TextStyle(fontSize: 15), // Set font size to 15
                      ),
                      // Text(
                      //   'Estimated Start Date: ${order.Id}',
                      //   style: TextStyle(fontSize: 15), // Set font size to 15
                      // ),
                      // Text(
                      //   'Estimated Start Date: ${order.userId.userId}',
                      //   style: TextStyle(fontSize: 15), // Set font size to 15
                      // ),
                      SizedBox(height: 20), // Add space between the last text and the button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Trigger the controller to send the request
                          // Update the button text if the request is sent
                          setState(() {
                            // Update the button text to 'Request Sent'
                            _workOrderController.sendRequest(order.Id,order.userId.userId,context);
                          });
                        },
                        icon: Icon(Icons.send), // Add send icon
                        label: Text('Request Sent'),
                         // Change button text to 'Request Sent'
                      ),SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            );
          } catch (e) {
            return Text('Error decoding image: $e');
          }
        }
      },
    );
  }
}
