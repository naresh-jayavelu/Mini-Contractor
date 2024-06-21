import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/workOrderRequestController.dart';
import 'package:mini_contractor_2/models/workOrderRequest.dart';

class Request extends StatefulWidget {
  Request({Key? key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final WorkOrderRequestController _requestController =
      WorkOrderRequestController();

  Future<void> _refreshRequests(BuildContext context) async {
    _requestController.clearData();

    // Fetch new data
    await _requestController.fetchrequests(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: SecureStorageService().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic> userData = snapshot.data ?? {};
          String userType = userData['type'] ?? '';

          return FutureBuilder<List<WorkOrderAssignment>>(
            future: _requestController.fetchrequests(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<WorkOrderAssignment> requests = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: () async {
                    await _refreshRequests(context);
                  },
                  child: ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      return _buildRequestCard(
                          context, requests[index], userType);
                    },
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildRequestCard(
      BuildContext context, WorkOrderAssignment request, String userType) {
    return Card(
      child: ListTile(
        title: Text(request.workOrderId.description),
        trailing: userType != contractorCode &&
                request.responseStatus == "Waiting"
            ? ElevatedButton(
                onPressed: () {
                  _requestController.AcceptRequest(
                      context, request.workOrderAssignmentId);
                },
                child: Text('Accept'),
              )
            : null, // Null if the condition is not met
        subtitle: userType == contractorCode
            ? Text('Status: ${request.responseStatus}')
            : Text('Status: ${request.responseStatus}'),
      ),
    );
  }
}
