import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/ReviewController.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/workOrderRequestController.dart';
import 'package:mini_contractor_2/models/workOrderRequest.dart';

class Review extends StatelessWidget {
  final ReviewAndComplaintsController _reviewController =
      ReviewAndComplaintsController();

  Review({Key? key});

  Future<void> addReview(BuildContext context, String workOrderID, String workorderassenment) async {
    double? rating; // Variable to store the rating value
    var comment = ''; // Placeholder for comment value

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              TextField(
                onChanged: (value) {
                  comment = value;
                },
                decoration: InputDecoration(hintText: 'Write here...'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (rating != null && rating! > 0 && comment.isNotEmpty) {
                  await _reviewController.addReview(
                    context,
                    rating.toString(),
                    comment,
                    workOrderID,
                    workorderassenment,
                  );
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please provide both rating and comment'),
                    ),
                  );
                }
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addComplaint(BuildContext context, String workOrderID, String workorderassenment) async {
    var comment = ''; // Placeholder for comment value

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write a Complaint'),
          content: TextField(
            onChanged: (value) {
              comment = value;
            },
            decoration: InputDecoration(hintText: 'Write here...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (comment.isNotEmpty) {
                  await _reviewController.addComplaint(
                    context,
                    comment,
                    workOrderID,
                    workorderassenment,
                  );
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a message'),
                    ),
                  );
                }
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<Map<String, dynamic>>(
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
              future: _reviewController.fetchrequests(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<WorkOrderAssignment> requests = snapshot.data ?? [];
                  return RefreshIndicator(
                    onRefresh: () async {
                      await _reviewController.fetchrequests(context);
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
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context, WorkOrderAssignment request, String userType) {
    return Card(
      child: ListTile(
        title: Text(request.workOrderId.description),
        subtitle: userType == contractorCode
            ? Text('Status: ${request.responseStatus}')
            : Text('Status: ${request.responseStatus}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (userType != contractorCode)
              ElevatedButton(
                onPressed: () {
                  addReview(context, request.workOrderId.id, request.workOrderAssignmentId);
                },
                child: Text('Review'),
              ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                addComplaint(context, request.workOrderId.id, request.workOrderAssignmentId);
              },
              child: Text('Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}
