from json import JSONDecodeError
from mailbox import Message
from pstats import Stats
import statistics
from django.forms import UUIDField, ValidationError
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse
from rest_framework import status
from django.db.models import Max
from django.db.models import Q
from django.db.models import Max
from django.db import transaction
from django.forms.models import model_to_dict

from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.http import HttpResponse,JsonResponse

from .serializer import ComplaintSerializer, ExpertiseSerializer, GenderSerializer, WorkOrder2Serializer, WorkOrderJoinSerializer2, WorkOrderSerializer,DocumentSerializer,AddressSerializer,UserSerializer,DocumentMappingSerializer,ContractorWorkProfilesSerializer,WorkOrderContractorPreferenceSerializer,WorkOrderProgressSerializer,ReviewSerializer,ServiceRequestSerializer,SearchSerializer,SearchResultSerializer,WorkOrderAssigmentSerializer,ContractorWorkProfileRequestSerializer,WorkOrderInvoiceSerializer,MessageSerializer,WorkOrderMessageSerializer,JobTypeSerializer, messegeListSerializer, orderMessegeSerializer, userjoinSerializer, workOrderAssigmentJoinSerializer

from . models import contractorWorkProfiles, document, documentType, expertise, gender, review, user,workOrder,jobType, workOrder2, workOrderAssigment, workOrderContractorPreference,Message

from django.http import JsonResponse
# from rest_framework.views import APIView
from .models import workOrder

class APIResponse:
    def __init__(self, success: bool, data):
        self.success = success
        self.data = data

    def to_json(self):
        return {
            'success': self.success,
            'data': self.data
        }

@csrf_exempt
def WorkOrderMessageApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error WorkOrderMessageApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error WorkOrderMessageApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error WorkOrderMessageApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error WorkOrderMessageApi",safe=False)
    else:
        return JsonResponse("else part WorkOrderMessageApi",safe=False)



@csrf_exempt
def workOrderInvoiceApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderInvoiceApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error workOrderInvoiceApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error workOrderInvoiceApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error workOrderInvoiceApi",safe=False)
    else:
        return JsonResponse("else part workOrderInvoiceApi",safe=False)


@csrf_exempt
def contractorWorkProfileRequestApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error contractorWorkProfileRequestApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error contractorWorkProfileRequestApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error contractorWorkProfileRequestApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error contractorWorkProfileRequestApi",safe=False)
    else:
        return JsonResponse("else part contractorWorkProfileRequestApi",safe=False)


@csrf_exempt
def workOrderAssigmentsApi(request, id='', type=''):
    print("haha")
    print(type)
    print(id)
    if request.method == 'GET':
        try:
            if id:
                if type == 'Contractor':
                    message = workOrderAssigment.objects.filter(contractorId=id).select_related('workOrderId')
                    serializer = workOrderAssigmentJoinSerializer(message, many=True)
                    print(serializer.data)
                    return JsonResponse(serializer.data, safe=False)
                else:
                    print("in")
                    messages = workOrderAssigment.objects.filter(workOrderId__clientId=id).select_related('workOrderId')
                    serializer = workOrderAssigmentJoinSerializer(messages, many=True)
                    return JsonResponse(serializer.data, safe=False)
            else:
                return JsonResponse("get error workOrderAssigmentApi", safe=False)
        except Exception as e:
            print(e)
            return JsonResponse("get error workOrderAssigmentApi", safe=False)


@csrf_exempt
def complaintsApi(request):
    print("haha")
    print(type)
    print(id)
    if request.method == 'GET':
        try:
            # Fetch complaints and related data
            complaints = workOrderAssigment.objects.filter(responseStatus='Complaint').select_related('workOrderId', 'contractorId')
            
            # Serialize complaints
            serializer = ComplaintSerializer(complaints, many=True)
            
            # Fetch related reviews for each workOrderAssigment
            complaints_data = serializer.data
            for complaint_data in complaints_data:
                print(complaint_data)
                complaint_id = complaint_data['workOrderId']['Id']
                # print(complaint_id)
                related_reviews = review.objects.filter(workOrderId=complaint_id)
                complaint_data['reviews'] = list(related_reviews.values())

            return JsonResponse(complaints_data, safe=False)
        except Exception as e:
            return JsonResponse({"error": "An error occurred while fetching data: {}".format(str(e))}, status=500)
# contractorProfileRemoveApi
@csrf_exempt
def contractorProfileRemoveApi(request, contractorWorkProfileId1):
    if request.method == 'DELETE':
        try:
            # Get the contractor work profile by ID
            print(contractorWorkProfileId1)
            contractor = contractorWorkProfiles.objects.get(contractorWorkProfileId=contractorWorkProfileId1)
            print(contractor)
            # Delete the contractor work profile
            contractor.delete()
            # Optionally, fetch updated contractor work profiles
            # combined_data = ...
            # Return a response
            return JsonResponse({'success': 'Contractor work profile deleted successfully'}, status=200)
        except contractorWorkProfiles.DoesNotExist:
            # Return an error response if the contractor work profile does not exist
            return JsonResponse({'success': 'Contractor work profile deleted successfully'}, status=200)
        except Exception as err:
            print(err)
            return JsonResponse({'error': err}, status=301)
    else:
        # Return a method not allowed response for other HTTP methods
        return JsonResponse({'error': 'Method not allowed'}, status=405)

@csrf_exempt
def contractor_login_api(request):
    if request.method == 'POST':
        email = request.POST.get('user[email]')
        password = request.POST.get('user[password]')

        try:
            contractor = user.objects.get(email=email, password=password, isActive=True)

            # Fetch contractor work profiles
            con_work_profiles = contractorWorkProfiles.objects.filter(contractorId=contractor)

            # Serialize the queryset to JSON serializable format
            con_work_profiles_data = ContractorWorkProfilesSerializer(con_work_profiles, many=True).data

            # Retrieve documentIds from contractorWorkProfiles queryset
            document_ids = [profile['documentId'] for profile in con_work_profiles_data]

            # Fetch documents based on documentIds
            docs = document.objects.filter(documentId__in=document_ids)
            
            # Serialize document queryset to JSON serializable format
            docs_data = [model_to_dict(doc) for doc in docs]
            
            # Combine document data with work profile data
            combined_data = []
            for profile in con_work_profiles_data:
                profile['documents'] = [doc for doc in docs_data if doc['documentId'] == profile['documentId']]
                combined_data.append(profile)
            print(combined_data)
            return JsonResponse(combined_data, safe=False)  # Set safe=False to allow non-dict objects to be serialized
        except user.DoesNotExist:
            return JsonResponse({'error': 'Invalid credentials'}, status=401)
    if request.method == 'POST':
        print("hii")
    else:
        return JsonResponse({'error': 'Method not allowed'}, status=405)@csrf_exempt
    
def extraApi(request, email='', password='', jobtype='', expertiseType=''):
    document_content = request.POST.get('document')  # Specify the key to retrieve
    print(document_content)
    print(email)
    print(password)
    print(jobtype)  # Correct variable name
    print(expertiseType)  # Correct variable name
        
    return JsonResponse({'error':'User not found'})

def documentUpdateApi(request):
    if request.method == 'POST':
        # Handle the POST request here
        # Extract data from the request
        # Process the data and perform necessary operations
        # Return a JSON response indicating success or failure
        
        # Example code for handling file upload
        user_email = request.POST.get('user[email]')
        user_password = request.POST.get('user[password]')
        job_type = request.POST.get('workProfile[jobType]')
        expertise1 = request.POST.get('workProfile[expertise]')
        document_content = request.POST.get('workProfile[document]')
        print(user_email)
        print(user_password)
        print(job_type)
        print(expertise1)
        data1=user.objects.filter(email=user_email,password=user_password,isActive=True)
        userdata=UserSerializer(data1).data
        if data1.exists():
            print(userdata)
            datafirst=data1.first()
            print(datafirst.userId)
            new_document_type = documentType.objects.get(name='certificate')
            new_document = document.objects.create(
                    file=document_content,
                    documentTypeId=new_document_type,
                    isActive=True
                )
            new_document.save()
            job_type = jobType.objects.get(pk=job_type)  # Fetch jobType instance
            expertise2 = expertise.objects.get(pk=expertise1)
            new_profile = contractorWorkProfiles.objects.create(
                contractorId=datafirst,
                jobTypeId=job_type,  # Assign jobType instance
                expertiseId=expertise2,
                documentId=new_document
            )
            new_profile.save()
        else:
            return JsonResponse({'error':'User not found'},status=405)
        # Process the document file as needed
        
        return JsonResponse({'message': 'Document uploaded successfully!'}, status=200)
    
    else:
        # Handle other HTTP methods if needed
        return JsonResponse({'error': 'Method not allowed'}, status=405)
@csrf_exempt
def reviewUpdateApi(request, id=''):
    print("haha")
    if request.method == 'GET':
        try:
            # Handle GET request
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi", safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print("Parsed JSON data:", data)
            serializer = ReviewSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return JsonResponse("posted successfully", safe=False)  
            else:
                return JsonResponse(serializer.errors, status=400)  

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
    else:
        return JsonResponse("Method not allowed", status=405)

@csrf_exempt
def updateRequestApi(request, id='', val=''):
    if request.method == 'PUT':
        try:
            with transaction.atomic():
                try:
                    data = workOrderAssigment.objects.get(workOrderAssigmentId=id)
                    data.responseStatus = val
                    data.save()
                    return JsonResponse("posted successfully", safe=False)
                except workOrderAssigment.DoesNotExist:
                    return JsonResponse("Work order assignment does not exist", status=404)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
    else:
        return HttpResponse("Method not allowed", status=405)


@csrf_exempt
def blockuserApi(request, id=''):
    if request.method == 'PUT':
        try:
            try:
                data = user.objects.get(userId=id)
                if (data.isActive):
                    data.isActive = False
                else:
                    data.isActive = True    
                print(data.isActive)
                data.save()
                return JsonResponse("posted successfully", safe=False)
            except workOrderAssigment.DoesNotExist:
                return JsonResponse("error assignment does not exist", status=404)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
    else:
        return HttpResponse("Method not allowed", status=405)


@csrf_exempt
def closecomplaintApi(request, id=''):
    if request.method == 'PUT':
        try:
            try:
                data = workOrderAssigment.objects.get(workOrderAssigmentId=id)
                data.responseStatus = 'Complaint Closed'    
                print(data.responseStatus)
                data.save()
                return JsonResponse("posted successfully", safe=False)
            except workOrderAssigment.DoesNotExist:
                return JsonResponse("error assignment does not exist", status=404)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
    else:
        return HttpResponse("Method not allowed", status=405)


@csrf_exempt
def acceptRequestApi(request, id=''):
    if request.method == 'PUT':
        try:
            with transaction.atomic():
                # Fetch the work order assignment
                try:
                    data = workOrderAssigment.objects.get(workOrderAssigmentId=id)
                except workOrderAssigment.DoesNotExist:
                    return JsonResponse("Work order assignment does not exist", status=404)
                work_order_id = data.workOrderId_id
                work_order_assignments = workOrderAssigment.objects.filter(workOrderId_id=work_order_id)
                for assignment in work_order_assignments:
                    if assignment.workOrderAssigmentId != id:
                        assignment.responseStatus = "Not Accepted"
                        assignment.save()
                data.responseStatus = "Accepted"
                data.save()

                return JsonResponse("posted successfully", safe=False)
                
        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
    else:
        # Handle GET requests or other HTTP methods
        return JsonResponse("Method not allowed", status=405)
# from django.http import JsonResponse

@csrf_exempt
def reviewsApi(request, id='',type=''):
    print(id)
    if request.method == 'GET':
        try:
            if type == 'Contractor':
                print("hsdbs")
                message = workOrderAssigment.objects.filter(Q(contractorId=id) & Q(responseStatus="Accepted")).select_related('workOrderId')
                serializer = workOrderAssigmentJoinSerializer(message, many=True)
                print(serializer.data)
                return JsonResponse(serializer.data, safe=False)
            else:
                print("in")
                message = workOrderAssigment.objects.filter(Q(workOrderId__clientId=id) & Q(responseStatus="Accepted")).select_related('workOrderId')
                serializer = workOrderAssigmentJoinSerializer(message, many=True)
                print(serializer.data)
                return JsonResponse(serializer.data, safe=False)
                messages = workOrderAssigment.objects.filter(workOrderId__clientId=id).select_related('workOrderId')
                serializer = workOrderAssigmentJoinSerializer(messages, many=True)
                return JsonResponse(serializer.data, safe=False)
            message = workOrderAssigment.objects.filter(Q(contractorId=id) & Q(responseStatus="Accepted")).select_related('workOrderId')
            serializer = workOrderAssigmentJoinSerializer(message, many=True)
            print(serializer.data)
            return JsonResponse(serializer.data, safe=False)
        except workOrderAssigment.DoesNotExist:
            return JsonResponse("Data not found", safe=False, status=404)

        except Exception as e:
            print(e)
            return JsonResponse("Internal Server Error", safe=False, status=500)

    # Handle other HTTP methods
    return JsonResponse("Method Not Allowed", safe=False, status=405)



@csrf_exempt
def documentApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print(data)
            # print("Parsed JSON data:", data)
            serializer = DocumentSerializer(data=data)
            # print(serializer.is_valid())
            if serializer.is_valid():
                # print("haha")
                serializer.save()
                
                return JsonResponse(serializer.data['documentId'], safe=False)  
            print("Serializer errors:", serializer.errors)
            print("Serializer error messages:", serializer.error_messages)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)


@csrf_exempt
def profileApi(request, id=''):
    if request.method == 'POST':
        try:
            document_content = request.POST.get('workProfile[document]')
            email = request.POST.get('user[email]')
            password = request.POST.get('user[password]')
            job_type_id = request.POST.get('workProfile[jobType]')
            expertise_id = request.POST.get('workProfile[expertise]')


            user_instance = user.objects.get(email=email, password=password)
            print(str(user_instance.roolId))
            print(str(user_instance.roolId)=="CONTRACTOR")
            if user_instance and str(user_instance.roolId)=="CONTRACTOR":
                json_data = {
                    'contractorId': user_instance.userId,
                    'jobTypeId': job_type_id,
                    'expertiseId': expertise_id,
                    'documentId': document_content
                }
                serializer = ContractorWorkProfilesSerializer(data=json_data)
                if serializer.is_valid():
                    serializer.save()
                    return JsonResponse(serializer.data, safe=False)
                else:
                    return JsonResponse(serializer.errors, status=400)
            else:
                return JsonResponse({"error": "Not a contractor"}, status=404)

        except Exception as e:
            error_message = str(e)
            print("Error:", error_message)
            return JsonResponse({"error": error_message}, status=500)


@csrf_exempt
def addressApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print("Parsed JSON data:", data)
            serializer = AddressSerializer(data=data)
            print(serializer.is_valid())
            if serializer.is_valid():
                print("haha")
                serializer.save()
                print(serializer.data)
                return JsonResponse(serializer.data['addressId'], safe=False) 
                return JsonResponse("posted successfully", safe=False)  # Use status code from rest_framework

            print("Serializer errors:", serializer.errors)
            print("Serializer error messages:", serializer.error_messages)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  # Use status code from rest_framework

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)


@csrf_exempt
def useraddApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print("Parsed JSON data:", data)
            serializer = UserSerializer(data=data)
            print(serializer.is_valid())
            if serializer.is_valid():
                print("haha")
                serializer.save()
                print(serializer.data)
                return JsonResponse("user created successfully", safe=False) 
                return JsonResponse("posted successfully", safe=False)  # Use status code from rest_framework

            print("Serializer errors:", serializer.errors)
            print("Serializer error messages:", serializer.error_messages)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  # Use status code from rest_framework

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)



@csrf_exempt
def contractoraddApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print("Parsed JSON data:", data['user'])
            print("Parsed JSON data:", data['address'])
            email = data['user'].get('email', None)
            if email and user.objects.filter(email=email).exists():
                print("email present")
                return JsonResponse("User with this email already exists", safe=False)
            
            # Assuming AddressSerializer is used for address data
            serializer2 = AddressSerializer(data=data['address'])
            if serializer2.is_valid():
                address_instance = serializer2.save()
                data['user']['addressId'] = address_instance.addressId  # Assuming 'id' is the address identifier in the Address model

                # Now you can use UserSerializer to handle user data with addressId included
                serializer = UserSerializer(data=data['user'])
                if serializer.is_valid():
                    serializer.save()
                    return JsonResponse("User created successfully", safe=False)
                else:
                    return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            else:
                return JsonResponse(serializer2.errors, status=status.HTTP_400_BAD_REQUEST)

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)



@csrf_exempt
def genderApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            expertise_data = gender.objects.all()
            serializer = GenderSerializer(expertise_data, many=True)
            return JsonResponse(serializer.data, safe=False)
        except Exception as e:
            return JsonResponse({"error": str(e)}, safe=False)
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    return JsonResponse("get error workOrderAssigmentApi",safe=False)

@csrf_exempt
def userApi(request, id=''):
    print(id)
    if request.method == 'GET':
        try:
            if id:
                # userdata = user.objects.get(userId=id)
                userdata = user.objects.select_related(
                        'roolId', 'addressId', 'genderId'
                    ).get(userId=id)
                content=userjoinSerializer(userdata)
                print(content.data)
                return JsonResponse(content.data,safe=False)
            else:
                userdata = user.objects.all().select_related('roolId', 'addressId', 'genderId')
    
                # Serialize the data
                content = userjoinSerializer(userdata, many=True)
                
                # Return JSON response
                return JsonResponse(content.data, safe=False)
                print(content.data)
                return JsonResponse(content.data,safe=False)
                return JsonResponse({'error': 'no user found'}, status=405)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    elif request.method == 'POST':
        print("naresh")
        return JsonResponse({'error': 'Method not allowed'}, status=405)
    else:
        # Handle other HTTP methods if needed
        return JsonResponse({'error': 'Method not allowed'}, status=405)



@csrf_exempt
def userupdateApi(request, id='',type='',data=''):
    print(id)
    if request.method == 'PUT':
        try:
            if id:
                if type=='email':    
                    userdata = user.objects.get(userId=id)
                    userdata.email=data
                    userdata.save()
                elif type=='pass':
                    userdata = user.objects.get(email=id)
                    userdata.password=data
                    userdata.save()
                else:
                    userdata = user.objects.get(userId=id)
                    userdata.phone=data
                    userdata.save()
                return JsonResponse("updated successfully",safe=False)
            else:
                return JsonResponse({'error': 'no user found'}, status=405)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        # Handle other HTTP methods if needed
        return JsonResponse({'error': 'Method not allowed'}, status=405)


@csrf_exempt
def workOrderUpdateApi(request, id='',type='',data=''):
    print(id)
    if request.method == 'PUT':
        try:
            if id:
                if type=='amount':    
                    workorderdata = workOrder2.objects.get(Id=id)
                    workorderdata.estimatedAmount=data
                    workorderdata.save()
                else:
                    workorderdata = workOrder2.objects.get(Id=id)
                    workorderdata.estimatedEndDate=data
                    workorderdata.save()
                return JsonResponse("updated successfully",safe=False)
            else:
                return JsonResponse({'error': 'no user found'}, status=405)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        # Handle other HTTP methods if needed
        return JsonResponse({'error': 'Method not allowed'}, status=405)



@csrf_exempt
def workOrder2Api(request, id=''):
    if request.method == 'GET':
        try:
            # Your GET method logic here
            pass
        except Exception as e:
            print("Error:", e)
            return JsonResponse("Error occurred in GET request", safe=False, status=500)
    
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            serializer = WorkOrder2Serializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return JsonResponse("Posted successfully", safe=False, status=200)  # Return appropriate status code

            errors = serializer.errors
            print("Serializer errors:", errors)
            return JsonResponse(errors, status=status.HTTP_400_BAD_REQUEST)

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)

    # Handle other HTTP methods here if needed

    return JsonResponse("Method not allowed", safe=False, status=405)

@csrf_exempt
def workOrderAssigmentApi(request,id=''):
    print("haha")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderAssigmentApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print("Parsed JSON data:", data)
            serializer = WorkOrderAssigmentSerializer(data=data)
            print(serializer.is_valid())
            if serializer.is_valid():
                print("haha")
                serializer.save()
                return JsonResponse("posted successfully", safe=False)  # Use status code from rest_framework

            print("Serializer errors:", serializer.errors)
            print("Serializer error messages:", serializer.error_messages)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  # Use status code from rest_framework

        except JSONDecodeError as e:
            print("JSON parse error:", e)
            return JsonResponse("Invalid JSON data", safe=False, status=400)

        except Exception as e:
            print("Internal Server Error:", e)
            return JsonResponse("Internal Server Error", safe=False, status=500)
            datas = JSONParser().parse(request)
            print(datas['workOrderId'])
            print()
            serializer = WorkOrderAssigmentSerializer(data=datas)
        
            # Instantiate an empty workOrderAssigment object
            workorder = workOrderAssigment()

            # Save the workorder object
            workorder.save()

            if serializer.is_valid():
                serializer.save()
                return Response("posted successfully", safe=False)
            print(serializer.errors)
            print(serializer.error_messages)
            return Response(serializer.errors, status=400)
        except Exception as e:
            print(e)
            return JsonResponse("post error MessageApi", safe=False, status=404)

    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error workOrderAssigmentApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error workOrderAssigmentApi",safe=False)
    else:
        return JsonResponse("else part workOrderAssigmentApi",safe=False)


@csrf_exempt
def searchResultApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error searchResultApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error searchResultApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error searchResultApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error searchResultApi",safe=False)
    else:
        return JsonResponse("else part searchResultApi",safe=False)


@csrf_exempt
def searchApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error searchApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error searchApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error searchApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error searchApi",safe=False)
    else:
        return JsonResponse("else part searchApi",safe=False)


@csrf_exempt
def serviceRequestApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error serviceRequestApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error serviceRequestApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error serviceRequestApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error serviceRequestApi",safe=False)
    else:
        return JsonResponse("else part serviceRequestApi",safe=False)


@csrf_exempt
def reviewApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error reviewApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error reviewApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error reviewApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error reviewApi",safe=False)
    else:
        return JsonResponse("else part reviewApi",safe=False)


@csrf_exempt
def workOrderProgressApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderProgressApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error workOrderProgressApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error workOrderProgressApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error workOrderProgressApi",safe=False)
    else:
        return JsonResponse("else part workOrderProgressApi",safe=False)

@csrf_exempt
def workOrderContractorPreferenceApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error workOrderContractorPreferenceApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error workOrderContractorPreferenceApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error workOrderContractorPreferenceApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error workOrderContractorPreferenceApi",safe=False)
    else:
        return JsonResponse("else part workOrderContractorPreferenceApi",safe=False)


@csrf_exempt
def contractorWorkProfilesApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return HttpResponse("get error contractorWorkProfilesApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error contractorWorkProfilesApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error contractorWorkProfilesApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error contractorWorkProfilesApi",safe=False)
    else:
        return JsonResponse("else part contractorWorkProfilesApi",safe=False)



@csrf_exempt
def documentMappingApi(request,id=0):
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error documentMappingApi",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error documentMappingApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error documentMappingApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error documentMappingApi",safe=False)
    else:
        return JsonResponse("else part documentMappingApi",safe=False)


# @csrf_exempt
# def addressApi(request,id=0):
#     if request.method=='GET':
#         try:
#             pass
#         except:
#             return JsonResponse("get error addressApi",safe=False)
#     elif request.method=='POST':
#         try:
#             addressdata = JSONParser().parse(request)
#             print("dfds")
#             print(addressdata)

#             address_serializer = AddressSerializer(data=addressdata)

#             if address_serializer.is_valid():
#                 address_serializer.save()
#                 print(address_serializer.data.get('addressId', None))
#                 return JsonResponse(address_serializer.data['addressId'], safe=False)
#             else:
#                 return JsonResponse("Address invaild serilizer", safe=False)
    #         print("dknfkjdsnfn")
    #         print(JSONParser().parse(request))
    #         addressdata=JSONParser().parse(request)
    #         print("dfds")
    #         print("dfds")
    #         print(addressdata)
    #         # print(Address.is_valid())
    #         Address=AddressSerializer(data=addressdata)
    #         Address.save()
    #         print(Address.is_valid())
    #         if Address.is_valid():
    #             Address.save()
    #             return JsonResponse("ADDED Successfully",safe=False)
    #         return JsonResponse("failed to add",safe=False)

    #         # return JsonResponse("post successful addressApi",safe=False)
    #     except Exception as err:
    #         print(err)
    #         return JsonResponse("post error addressApi",safe=False)
    # elif request.method=='PUT':
    #     try:
    #         pass
    #     except:
    #         return JsonResponse("put error addressApi",safe=False)
    # elif request.method=='DELETE':
    #     try:
    #         pass
    #     except:
    #         return JsonResponse("delete error addressApi",safe=False)
    # else:
    #     return JsonResponse("else part addressApi",safe=False)


# @csrf_exempt
# def documentApi(request,id=0):
#     if request.method=='GET':
#         try:
#             pass
#         except:
#             return JsonResponse("get error documentApi",safe=False)
#     elif request.method=='POST':
#         try:
#             pass
#         except:
#             return JsonResponse("post error documentApi",safe=False)
#     elif request.method=='PUT':
#         try:
#             pass
#         except:
#             return JsonResponse("put error documentApi",safe=False)
#     elif request.method=='DELETE':
#         try:
#             pass
#         except:
#             return JsonResponse("delete error documentApi",safe=False)
#     else:
#         return JsonResponse("else part documentApi",safe=False)
@csrf_exempt
def expertiseApi(request, id=0):
    if request.method == 'GET':
        try:
            expertise_data = expertise.objects.all()
            serializer = ExpertiseSerializer(expertise_data, many=True)
            print(serializer.data)
            return JsonResponse(serializer.data, safe=False)
        except Exception as e:
            print({"error": str(e)})
            return JsonResponse({"error": str(e)}, safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error documentApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("get error documentApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error documentApi",safe=False)
    else:
        return JsonResponse("else part documentApi",safe=False)

# http://127.0.0.1:8000/jobType/a6c24248-16fd-4e9d-b0db-337a2b26ff2d
@csrf_exempt
def jobTypeApi(request,id=''):
    if request.method=='GET':
        try:
            if id:
                print("dsfds")
                jobTypes = jobType.objects.get(jobTypeId=id)
                content=JobTypeSerializer(jobTypes).data['jobTypeName']
                return JsonResponse(content,safe=False)
            expertise_data = jobType.objects.all()
            serializer = JobTypeSerializer(expertise_data, many=True)
            return JsonResponse(serializer.data, safe=False)
        except Exception as a:
            print(a)
            return JsonResponse("haha error work order api",safe=False)
    elif request.method=='POST':
        try:
            pass
        except:
            return JsonResponse("post error documentApi",safe=False)
    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error documentApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error documentApi",safe=False)
    else:
        return JsonResponse("else part documentApi",safe=False)


@csrf_exempt
def MessageApi(request,id=0):
    print("naresh")
    if request.method=='GET':
        try:
            pass
        except:
            return JsonResponse("get error MessageApi",safe=False)
    elif request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            print(data)
            serializer = MessageSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return JsonResponse("posted successfully", safe=False)
            print(serializer.errors)
            print(serializer.error_messages)
            return JsonResponse(serializer.errors, status=400)
        except Exception as e:
            print(e)
            return JsonResponse("post error MessageApi", safe=False, status=404)


    elif request.method=='PUT':
        try:
            pass
        except:
            return JsonResponse("put error MessageApi",safe=False)
    elif request.method=='DELETE':
        try:
            pass
        except:
            return JsonResponse("delete error MessageApi",safe=False)
    else:
        return JsonResponse("else part MessageApi",safe=False)


@csrf_exempt
def workorderJoinApi(request,id=''):
    print(id)
    if request.method=='GET':
        # return JsonResponse(id,safe=False)
        try:
            if len(id) != 0:
                try:
                    workOrderData = workOrder2.objects.select_related(
                        'addressId', 'document', 'jobTypeId', 'expertiseId','clientId'
                    ).get(Id=id)
                    
                    # Use the serializer to serialize the data
                    serializer = WorkOrderJoinSerializer2(workOrderData)
                    print(serializer.data)
                    # Convert serializer.data to a dictionary
                    data_dict = dict(serializer.data)
                    print(data_dict)
                    return JsonResponse(data_dict, safe=False)
                except workOrder2.DoesNotExist:
                    print(id)
                    print("not exist")
                    return JsonResponse({"error": "Work Order not found"}, status=404)
                except Exception as e:
                    print("not exist2")
                    return JsonResponse({"error": str(e)}, status=500)
        except Exception as e:
            print("not exist3")
            return JsonResponse({"error": str(e)}, status=400)
    else:
        # Handle other HTTP methods if necessary
        return JsonResponse({"error": "Method not allowed"}, status=405)
        try:
            if len(id)!=0:
                try:
                    workOrderData = workOrder.objects.select_related(
                        'address', 'document', 'jobType', 'expertise'
                    ).get(Id=id)
                    
                    # Use the serializer to serialize the data
                    serializer = WorkOrderJoinSerializer(workOrderData)
                    
                    # Convert serializer.data to a dictionary
                    data_dict = dict(serializer.data)
                    print(serializer.data)
                    return JsonResponse(data_dict, safe=False)
                    # workOrderData = workOrder.objects.get(Id=id)
                    print("sbf")
                    workOrderData = workOrder.objects.select_related(
                        'address', 'documentMapping', 'jobType', 'expertise'
                    ).get(Id=id)
                    
                    print("sbf")
                    content = WorkOrderJoinSerializer(workOrderData)
                    print(content.data)
                    return JsonResponse(content.data, safe=False)
                except Exception as e:
                    return JsonResponse({"error": "Work Order not found "+e}, status=404) 
        except:
            return JsonResponse("jfgnjfng")
        
@csrf_exempt
def MessageDataApi(request, id='',userId=''):
    if request.method == 'GET':
        # Handle POST request
        if id:
            # If an ID is provided in the URL, return specific message data
            try:
                # workOrderData = workOrder2.objects.select_related(
                #         'addressId', 'document', 'jobTypeId', 'expertiseId','clientId'
                #     ).get(Id=id)
                # messages = Message.objects.filter(workOrder=id).filter(Q(actionedOn=userId) | Q(userId=userId))
                message = Message.objects.filter(workOrder=id).filter(Q(actionedOn=userId) | Q(userId=userId)).select_related(
                    'actionedOn','documentId','userId'
                )
                serializer = orderMessegeSerializer(message,many=True)
                print(serializer.data)
                return JsonResponse(serializer.data, safe=False)
            except Message.DoesNotExist:
                return JsonResponse({"error": "Message not found"}, status=404)
        else:
            # If no ID provided, return all messages
            messages = Message.objects.all()
            serializer = MessageSerializer(messages, many=True)
            return JsonResponse(serializer.data, safe=False)
    else:
        # Handle other HTTP methods
        return JsonResponse({"error": "Method not allowed"}, status=405)

@csrf_exempt
def MessageListApi(request, id=''):
    if request.method == 'GET':
        if id:
            try:
                # Group messages by work order and find the latest message for each group
                latest_messages = (
                    Message.objects.filter(userId=id) | Message.objects.filter(actionedOn=id)
                ).values('workOrder').annotate(max_time=Max('time2'))

                print("naresh ij")
                # Initialize an empty list to store serialized message data
                serialized_data = []

                # Loop through each group of messages
                for item in latest_messages:
                    work_order = item['workOrder']
                    max_time = item['max_time']

                    # Find the latest message for the current work order
                    latest_message = Message.objects.filter(
                        (Q(userId=id) | Q(actionedOn=id)) & Q(workOrder=work_order) & Q(time2=max_time)
                    ).select_related('workOrder').first()

                    # Serialize the latest message and add it to the list
                    if latest_message:
                        serialized_data.append(messegeListSerializer(latest_message).data)

                print(serialized_data)
                return JsonResponse(serialized_data, safe=False)
            except Message.DoesNotExist:
                return JsonResponse({"error": "Message not found"}, status=404)

        else:
            messages = Message.objects.all()
            serializer = messegeListSerializer(messages, many=True)
            return JsonResponse(serializer.data, safe=False)
    else:
        return JsonResponse({"error": "Method not allowed"}, status=405)
@csrf_exempt
def isFirstApi(request, id='', userId=''):
    if request.method == 'GET':
        if id:
            try:
                messages = Message.objects.filter(workOrder=id).filter(Q(actionedOn=userId) | Q(userId=userId))
                serializer = MessageSerializer(messages, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Message.DoesNotExist:
                return JsonResponse({"error": "No messages found for the given work order and user ID"}, status=404)
            except Exception as e:
                return JsonResponse({"error": f"An error occurred: {str(e)}"}, status=500)
        else:
            messages = Message.objects.all()
            serializer = MessageSerializer(messages, many=True)
            return JsonResponse(serializer.data, safe=False)
    else:
        # Handle other HTTP methods
        return JsonResponse({"error": "Method not allowed"}, status=405)

# @csrf_exempt
# def MessageListApi(request, id=''):
#     if request.method == 'GET':
#         if id:
#             try:
#                 first_message_ids = Message.objects.filter(
#                     userId=id
#                 ).values(
#                     'workOrder'
#                 ).annotate(
#                     min_message_id=Max('messageId')
#                 ).values_list(
#                     'min_message_id', flat=True
#                 )

#                 # Query to retrieve the first message for each work order
#                 first_messages = Message.objects.filter(
#                     messageId__in=Subquery(first_message_ids)
#                 ).select_related('workOrder').order_by('-time2')[:2]  # Slice to limit to 2 results

#                 # Serialize the data
#                 serializer = MessageSerializer(first_messages, many=True)
#                 return JsonResponse(serializer.data, safe=False)
#             except Message.DoesNotExist:
#                 return JsonResponse({"error": "Message not found"}, status=404)
#         else:
#             messages = Message.objects.all()
#             serializer = MessageSerializer(messages, many=True)
#             return JsonResponse(serializer.data, safe=False)
#     else:
#         return JsonResponse({"error": "Method not allowed"}, status=405)

@csrf_exempt
def workOrderApi(request,id=''):
    print(id)
    print("oh")
    if request.method=='GET':
        if len(id)!=0:
            try:
                workOrderData = workOrder2.objects.filter(clientId=id)
                content = WorkOrder2Serializer(workOrderData,many=True).data
                print(content)
                return JsonResponse(content, safe=False)
            except workOrder.DoesNotExist:
                return JsonResponse({"error": "Work Order not found"}, status=404)
        try:
            workorders=workOrder2.objects.filter(status='Active')
            context = WorkOrder2Serializer(workorders,many=True)
            print(context.data)
            return JsonResponse(context.data,safe=False)
        except:
            return JsonResponse("get error work order api",safe=False)
    elif request.method=='POST':
        try:
            print("in the post comment")
            print(request)
            workorderdata=JSONParser().parse(request)
            print(workorderdata)
            # Addressobj=AddressSerializer(
            #     addressLine1=workorderdata.addressLine1,
            #     addressLine2=workorderdata.addressLine2+workorderdata.city,
            #     pincode=workorderdata.pincode,
            #     state=workorderdata.state,
            #     country=workorderdata.country,
            #     latitude=workorderdata.latitude,
            #     longitude=workorderdata.longitude,
            #     isActive=True,
            # )
            WorkOrderSerializerobj = WorkOrderSerializer(
                description=workorderdata.discription,
                status="Active",
                estimatedStartDate=workorderdata.estimatedStartDate,
                estimatedEndDate=workorderdata.estimatedEndDate,
                documentMappingID="",
                jobTypeId=workorderdata.jobTypeId,
                expertiseId=workorderdata.expertiseId,
                addressId="",
                isAssigned=False,
                isActive=True,
            )

            print(WorkOrderSerializerobj)
            workorders=WorkOrderSerializer(data=workorderdata)
            if workorders.is_valid():
                workorders.save()
                return JsonResponse("ADDED Successfully",safe=False)
            return JsonResponse("failed to add",safe=False)
        except:
            return JsonResponse("post error work order api",safe=False)
    elif request.method == 'PUT':
        if id:
            try:
                workorder_data = JSONParser().parse(request)
                workorder = workOrder.objects.get(workOrderId=workorder_data['workOrderId'])
                workorder_serializer = WorkOrderSerializer(workorder, data=workorder_data)
                if workorder_serializer.is_valid():
                    workorder_serializer.save()
                    return JsonResponse("Updated Successfully", safe=False)
                return JsonResponse("Failed to update", safe=False)
            except:
                return JsonResponse("put error work order api",safe=False)
        # 127.0.0.1:8000/workorder?id=12961d08-9c33-4dc1-a7dd-79c3e5ec8c04
        # {"workOrderId": "12961d08-9c33-4dc1-a7dd-79c3e5ec8c04", "description": "painting the home", "estimatedAmount": "2000", "status": "active", "estimatedStartDate": "20-12-2023", "estimatedEndDate": "31-12-2023", "isAssigned": false, "isActive": true, "documentMappingID": "75963d1c-fc1f-4f17-9bca-0bd99d729c63", "jobTypeId": "634a3396-a38a-4f65-b7b8-074c505c7776", "expertiseId": "ce0ef3b1-9029-48de-b6ae-e1b75c1f214a", "addressId": "9b41c822-2c0b-4600-a53a-2da55d337d5b"}
        try:
            workorder_data = JSONParser().parse(request)
            workorder = workOrder.objects.get(workOrderId=workorder_data['workOrderId'])
            workorder_serializer = WorkOrderSerializer(workorder, data=workorder_data)
            if workorder_serializer.is_valid():
                workorder_serializer.save()
                return JsonResponse("Updated Successfully", safe=False)
            return JsonResponse("Failed to update", safe=False)
        except:
            return JsonResponse("put error work order api",safe=False)
    elif request.method=='DELETE':
        # {"workOrderId": "61a0bcca-c483-47dc-96e4-bb5953c44e2b"}
        # 127.0.0.1:8000/workorder?id=61a0bcca-c483-47dc-96e4-bb5953c44e2b
        try:
            workorder_data=JSONParser().parse(request)
            workorder=workOrder.objects.get(workOrderId=workorder_data['workOrderId'])
            if(workorder):
                workorder.delete()
                return JsonResponse("Deleted Successfully",safe=False)
        except:
            return JsonResponse("delete error work order api",safe=False)
        else:
            return JsonResponse("No records to delete",safe=False)
    else:
        return JsonResponse("request invalid",safe=False)
   

@api_view(['GET'])
def home(request):
    workorders = workOrder.objects.all()
    context = WorkOrderSerializer(workorders,many=True)
    return JsonResponse(context.data,safe=False)
    
@api_view(['POST']) 
def homes(request):
    print("its post")
    print(JSONParser().parse(request))

    # workorders = workOrder.objects.all()
    # context = WorkOrderSerializer(workorders,many=True)
    return JsonResponse()
    

@api_view(['GET'])
def roles(request):
    print("dfds")
    roles=user.objects.all()
    context=list(roles.values())
    return Response(context)
    return JsonResponse({'roles': list(roles.values())})

def role(request,pk):    
    roles=user.objects.get(userId=pk).join(pk)
    # return jsonrequest(roles)
    # return JsonResponse(roles)
    return Response(roles)

# def createUser

def role(request,pk):    
    roles=user.objects.get(userId=pk)
    # return jsonrequest(roles)
    # return JsonResponse(roles)
    return HttpResponse(roles)

# def home(request):

#     return htt
# @APIView(['GET'])
def mix(request):
    users_with_roles = user.objects.select_related('roolId').all()
    
    users_data = [
        {
            'userId': user.userId,
            'email': user.email,
            'firstName': user.firstName,
            'lastName': user.lastName,
            'RoleCode': user.roolId.RoleCode,
            'RoleName': user.roolId.RoleName,
            'role': {
                'RoleCode': user.roolId.RoleCode,
                'RoleName': user.roolId.RoleName,
                'RoleDescription': user.roolId.RoleDescription,
                'isActive': user.roolId.isActive,
                'id': str(user.roolId.id),
            }
        }
        for user in users_with_roles
    ]

    return Response({'users_with_roles': users_data})

@csrf_exempt
def loginApi(request):
    if request.method == 'GET':
        try:
            email = request.GET.get('email')
            password = request.GET.get('password')
            userdata = user.objects.get(email=password, password=email, isActive=True)
            content = UserSerializer(userdata).data
            responseData = APIResponse(True, content)
            print(content)
            return JsonResponse(responseData.to_json(), safe=False)
        except user.DoesNotExist:
            responseData = APIResponse(False, "Invalid Email or Password")
            print('Invalid Email or Password')
            return JsonResponse(responseData.to_json(), safe=False)
        except Exception as e:
            responseData = APIResponse(False, "An error occurred: " + str(e))
            print("An error occurred: " + str(e))
            return JsonResponse(responseData.to_json(), safe=False)
    else:
        responseData = APIResponse(False, "Error in login page api")
        return JsonResponse(responseData.to_json(), safe=False)

    # if request.method=='GET':
    #     # return JsonResponse(id,safe=False)
    #     try:
    #         if len(password) != 0:
    #             try:
    #                 workOrderData = workOrder.objects.select_related(
    #                     'addressId', 'documentMappingID', 'jobTypeId', 'expertiseId'
    #                 ).get(Id=id)
                    
    #                 # Use the serializer to serialize the data
    #                 serializer = WorkOrderJoinSerializer(workOrderData)
                    
    #                 # Convert serializer.data to a dictionary
    #                 data_dict = dict(serializer.data)
                    
    #                 return JsonResponse(data_dict, safe=False)
    #             except workOrder.DoesNotExist:
    #                 return JsonResponse({"error": "Work Order not found"}, status=404)
    #             except Exception as e:
    #                 return JsonResponse({"error": str(e)})
    #     except Exception as e:
    #         return JsonResponse({"error": str(e)})
    



 # elif request.method == 'PUT':
    #     workorder_data = JSONParser().parse(request)
    #     try:
    #         workorder = workOrder.objects.get(workOrderId=id)
    #     except workOrder.DoesNotExist:
    #         return JsonResponse("WorkOrder not found", status=404)

    #     workorder_serializer = WorkOrderSerializer(workorder, data=workorder_data)
    #     if workorder_serializer.is_valid():
    #         workorder_serializer.save()
    #         return JsonResponse("Updated Successfully", safe=False)
    #     return JsonResponse("Failed to update", safe=False)
    # else:
    #     return JsonResponse("Invalid HTTP method", status=400)
    # {"workOrderId": "12961d08-9c33-4dc1-a7dd-79c3e5ec8c04", "description": "painting the home", "estimatedAmount": "2000", "status": "active", "estimatedStartDate": "20-12-2023", "estimatedEndDate": "31-12-2023", "isAssigned": false, "isActive": true, "documentMappingID": "75963d1c-fc1f-4f17-9bca-0bd99d729c63", "jobTypeId": "634a3396-a38a-4f65-b7b8-074c505c7776", "expertiseId": "ce0ef3b1-9029-48de-b6ae-e1b75c1f214a", "addressId": "9b41c822-2c0b-4600-a53a-2da55d337d5b"}
    # { "description": "painting the home", "estimatedAmount": "2000", "status": "active", "estimatedStartDate": "20-12-2023", "estimatedEndDate": "31-12-2023", "isAssigned": false, "isActive": true, "documentMappingID": "75963d1c-fc1f-4f17-9bca-0bd99d729c63", "jobTypeId": "634a3396-a38a-4f65-b7b8-074c505c7776", "expertiseId": "ce0ef3b1-9029-48de-b6ae-e1b75c1f214a", "addressId": "9b41c822-2c0b-4600-a53a-2da55d337d5b"}
    # elif request.method == 'PUT':
    #     workorder_data = JSONParser().parse(request)
    #     workorder = workOrder.objects.get(workOrderId=id)
    #     # workorder = workorders.objects.get(id=workorder_data['workOrderId'])
    #     workorder_serializer = WorkOrderSerializer(workorder, data=workorder_data)
    #     if workorder_serializer.is_valid():
    #         workorder_serializer.save()
    #         return JsonResponse("Updated Successfully", safe=False)
    #     return JsonResponse("Failed to update", safe=False)
    # else:
    #     return JsonResponse("else Successfully",safe=False)

# class home(APIView):
#     def get(self, request):
#         workorders = workOrder.objects.all()
#         context = list(workorders.values())
#         return JsonResponse({'workorders': context}, safe=False)
# @api_view(['GET'])
# def home(request):
#     workorders = workOrder.objects.all()
#     context = list(workorders.values())
#     return JsonResponse(context,safe=False)




# for react code


    
