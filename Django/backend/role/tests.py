from mailbox import Message
from uuid import uuid4
from xml.dom.minidom import Document
from django.test import RequestFactory, TestCase
from django.urls import reverse
from .models import document, documentType, user, workOrder2, workOrderAssigment 
from .serializer import UserSerializer 
from .views import loginApi, workOrderAssigmentApi, workorderJoinApi  
from django.test import TestCase, Client
import json

class LoginApiTestCase(TestCase):
    def setUp(self):
        self.factory = RequestFactory()
        # Create a sample user
        self.test_user = user.objects.create(
            email='naresh.jayavelu@gmail.com',
            password='1001',
            isActive=True
        )

    def test_successful_login(self):
        url = reverse('login') 
        data = {'email': '1001', 'password': 'naresh.jayavelu@gmail.com'}
        response = self.client.get(url, data)
        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.json()['success'])
        self.assertEqual(response.json()['data']['email'], 'naresh.jayavelu@gmail.com')

    # def test_failed_login_invalid_credentials(self):
    #     url = reverse('login')
    #     data = {'email': 'naresh.jayavelu@gmail.com', 'password': 'wrong_password'}
    #     response = self.client.get(url, data)

    #     self.assertEqual(response.status_code, 200)
    #     self.assertFalse(response.json()['success'])
    #     self.assertEqual(response.json()['data'], 'Invalid Email or Password')
        
    # def test_failed_login_inactive_user(self):
    #     self.test_user.isActive = False
    #     self.test_user.save()

    #     url = reverse('login')
    #     data = {'email': 'root', 'password': 'mothi@shri.ram'}
    #     print("test_failed_login_inactive_user")
    #     response = self.client.get(url, data)

    #     self.assertEqual(response.status_code, 200)
    #     self.assertFalse(response.json()['success'])
    #     self.assertEqual(response.json()['data'], 'Invalid Email or Password')
        
    # def test_error_handling(self):
    #     url = reverse('login')  
    #     data = {'email': 'invalid@example.com', 'password': 'invalid_password'}
    #     response = self.client.get(url, data)
    #     self.assertEqual(response.status_code, 200)
    #     self.assertFalse(response.json()['success'])
    #     self.assertEqual(response.json()['data'], ' Email or Password')
        
# class WorkOrderJoinApiTestCase(TestCase):
#     def setUp(self):
#         self.factory = RequestFactory()
#         self.test_order = workOrder2.objects.create(
#             description='',
#             estimatedAmount='',
#             status='',
#             estimatedStartDate='',
#             estimatedEndDate='',
#             isAssigned='',
#             isActive=True 
#         )

#     def test_get_workorder_join_api(self):
#         url = reverse('workorderJoin', kwargs={'id': self.test_order.id})
#         response = self.client.get(url)
#         self.assertEqual(response.status_code, 200)
#         print(response.status_code)

#     def test_get_workorder_join_api_invalid_id(self):
#         invalid_id = str(uuid4())
#         url = reverse('workorderJoin', kwargs={'id': invalid_id})
#         response = self.client.get(url)
#         self.assertEqual(response.status_code, 404)
#         print(response.status_code)

# from rest_framework.test import APIClient

# class WorkOrderAssigmentApiTestCase(TestCase):
#     def setUp(self):
#         self.client = APIClient()

#     def test_post_workorder_assigment_api(self):
#         post_data = {
#             "workOrderId": 'ef070c6a-5fc2-40a2-ac56-d70e2d624380',
#             "contractorId": '91008c5f-6714-4d00-9658-5cb5f77c7876',
#             "requestStatus": "Pending",
#             "responseStatus": "Accepted"
#         }

#         url = reverse('workOrderAssigment')

#         response = self.client.post(url, data=post_data, format='json')
#         self.assertEqual(response.status_code, 200)
    
# class WorkOrderJoinApiTestCase(TestCase):
#     def setUp(self):
#         self.factory = RequestFactory()
#         # Create a sample work order object for testing
#         self.work_order = workOrder2.objects.create(addressId='Address 1', document='Document 1', jobTypeId='Job Type 1', expertiseId='Expertise 1', clientId='Client 1')

#     def test_workorder_join_api(self):
#         # Create a GET request with an ID parameter
#         url = reverse('workorder-join-api')  # Make sure to replace 'workorder-join-api' with the actual URL name
#         request = self.factory.get(url, {'id': self.work_order.Id})

#         # Call the view function
#         response = workorderJoinApi(request, id=str(self.work_order.Id))

#         # Check if the response status code is 200
#         self.assertEqual(response.status_code, 200)

#         # Check if the work order data is returned in the response
#         self.assertContains(response, self.work_order.addressId)
#         self.assertContains(response, self.work_order.document)
#         self.assertContains(response, self.work_order.jobTypeId)
#         self.assertContains(response, self.work_order.expertiseId)
#         self.assertContains(response, self.work_order.clientId)

#     def test_workorder_join_api_invalid_id(self):
#         # Create a GET request with an invalid ID parameter
#         url = reverse('workorder-join-api')  # Make sure to replace 'workorder-join-api' with the actual URL name
#         request = self.factory.get(url, {'id': 'invalid_id'})

#         # Call the view function
#         response = workorderJoinApi(request, id='invalid_id')

#         # Check if the response status code is 404
#         self.assertEqual(response.status_code, 404)
