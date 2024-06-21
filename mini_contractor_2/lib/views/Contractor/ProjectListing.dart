import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/workOrderController.dart';
import 'package:mini_contractor_2/models/workOrderModel.dart';
import 'package:mini_contractor_2/reference/shoppingview.dart';
import 'package:mini_contractor_2/views/Chat.dart';
import 'package:mini_contractor_2/views/Contractor/OrderDetails.dart';

class ProjectListing extends StatelessWidget {
  final WorkOrderController _workOrderController = WorkOrderController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<workOrder>>(
      future: _workOrderController.fetchWorkOrders(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<workOrder> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return buildCard(context, data[index]);
            },
          );
        }
      },
    );
  }

  Widget buildCard(BuildContext context, workOrder order) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.work),
            title: FutureBuilder<String>(
              future: _workOrderController.fetchJobType(order.jobTypeId,context),
              builder: (context, jobTypeSnapshot) {
                if (jobTypeSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (jobTypeSnapshot.hasError) {
                  return Text('Error fetching job type: ${jobTypeSnapshot.error}');
                } else {
                  String jobType = jobTypeSnapshot.data!;
                  return Text(jobType);
                }
              },
            ),
            subtitle: Text(order.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // TextButton(
              //   child: Text('Bookmark'),
              //   onPressed: () {
              //     // Handle bookmark action
              //   },
              // ),
              // SizedBox(width: 8),
              TextButton(
                child: Text('Details'),
                onPressed: () {
                  // Navigate to order detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetail(workOrderId: order.Id,)),
                    // MaterialPageRoute(builder: (context) => OrderDetail(workOrderId: order.id)),
                  );
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
