import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/workOrderController.dart';
import 'package:mini_contractor_2/models/workOrderModel.dart';
import 'package:mini_contractor_2/views/AddWorkOrder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WorkOrderController _workOrderController = WorkOrderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshWorkOrders(context),
        child: FutureBuilder<List<workOrder>>(
          future: _workOrderController.fetchMyOrders(context),
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
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to the page where you can add a new project
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddWorkOrder()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  Future<void> _refreshWorkOrders(BuildContext context) async {
    // Fetch new data
    await _workOrderController.fetchMyOrders(context);
    // Update the UI by calling setState
    setState(() {});
  }

  Widget buildCard(BuildContext context, workOrder order) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.work),
            title: FutureBuilder<String>(
              future: _workOrderController.fetchJobType(order.jobTypeId, context),
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.description),
                SizedBox(height: 8),
                Text('Estimated Amount: ${order.estimatedAmount}'),
                Text('Estimated Start Date: ${order.estimatedStartDate.toString().split(' ')[0]}'),
                Text('Estimated End Date: ${order.estimatedEndDate.toString().split(' ')[0]}'),
                Text('Status: ${order.status}'),
              ],
            ),
          ),
          if (order.status == 'Active')
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('Edit Amt'),
                  onPressed: () {
                    _showEditAmountDialog(context, order);
                  },
                ),
                SizedBox(width: 8),
                TextButton(
                  child: Text('Edit End Time'),
                  onPressed: () {
                    _showEditEndTimeDialog(context, order);
                  },
                ),
                SizedBox(width: 8),
              ],
            ),
        ],
      ),
    );
  }
void _showEditAmountDialog(BuildContext context, workOrder order) {
  TextEditingController amountController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Estimated Amount'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'New Amount'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Check if amount is empty
              if (amountController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter the amount'),
                  ),
                );
              } else {
                // Make PUT API call to update the amount
                _workOrderController.updateworkorder(order.Id, amountController.text,"amount", context);
                Navigator.of(context).pop(); // Close dialog
      setState(() {});
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
void _showEditEndTimeDialog(BuildContext context, workOrder order) {
  DateTime selectedDate = DateTime.now().add(Duration(days: 1)); // Default to tomorrow

  TextEditingController endTimeController = TextEditingController(text: selectedDate.toString().split(' ')[0]); // Extract date portion only

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Estimated End Time'),
        content: GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now().add(Duration(days: 1)), // Restrict selection to tomorrow onwards
              lastDate: DateTime(2100), // Adjust as needed
            );

            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
                endTimeController.text = pickedDate.toString().split(' ')[0]; // Update text field with selected date only
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: endTimeController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'New End Time'),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Make PUT API call to update the estimated end time
              _workOrderController.updateworkorder(order.Id, selectedDate.toString(),"Date", context);
              
      setState(() {});
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

}
