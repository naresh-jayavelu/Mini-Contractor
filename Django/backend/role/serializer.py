from rest_framework import serializers
from .models import (
    role, gender, documentType, document, jobType, expertise, address,
    user, documentMapping, contractorWorkProfiles, workOrder,
    workOrderContractorPreference, workOrderProgress, review, serviceRequest,
    search, searchResult, workOrderAssigment, contractorWorkProfileRequest,
    workOrderInvoice, Message, WorkOrderMessage,workOrder2
)

class WorkOrder2Serializer(serializers.ModelSerializer):
    class Meta:
        model = workOrder2
        fields = '__all__'


class RoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = role
        fields = '__all__'

class GenderSerializer(serializers.ModelSerializer):
    class Meta:
        model = gender
        fields = '__all__'

class DocumentTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = documentType
        fields = '__all__'

class DocumentSerializer(serializers.ModelSerializer):
    class Meta:
        model = document
        fields = '__all__'

class JobTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = jobType
        fields = '__all__'

class ExpertiseSerializer(serializers.ModelSerializer):
    class Meta:
        model = expertise
        fields = '__all__'

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = address
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = user
        fields = '__all__'

class DocumentMappingSerializer(serializers.ModelSerializer):
    class Meta:
        model = documentMapping
        fields = '__all__'

class ContractorWorkProfilesSerializer(serializers.ModelSerializer):
    class Meta:
        model = contractorWorkProfiles
        fields = '__all__'

class WorkOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = workOrder
        fields = '__all__'

class WorkOrderContractorPreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = workOrderContractorPreference
        fields = '__all__'

class WorkOrderProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = workOrderProgress
        fields = '__all__'

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = review
        fields = '__all__'

class ServiceRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = serviceRequest
        fields = '__all__'

class SearchSerializer(serializers.ModelSerializer):
    class Meta:
        model = search
        fields = '__all__'

class SearchResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = searchResult
        fields = '__all__'

class WorkOrderAssigmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = workOrderAssigment
        fields = '__all__'

class ContractorWorkProfileRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = contractorWorkProfileRequest
        fields = '__all__'

class WorkOrderInvoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = workOrderInvoice
        fields = '__all__'

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = '__all__'

class WorkOrderMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkOrderMessage
        fields = '__all__'

# serializers.py
class WorkOrderJoinSerializer2(serializers.ModelSerializer):
    addressId = AddressSerializer()
    document = DocumentSerializer()
    jobTypeId = JobTypeSerializer()
    expertiseId = ExpertiseSerializer()
    clientId=UserSerializer()

    class Meta:
        model = workOrder2
        fields = '__all__'

class orderMessegeSerializer(serializers.ModelSerializer):
    actionedOn = UserSerializer()
    documentId = DocumentSerializer()
    userId = UserSerializer()

    class Meta:
        model = Message
        fields = '__all__'
        
class userjoinSerializer(serializers.ModelSerializer):
    roolId = RoleSerializer()
    addressId = AddressSerializer()
    genderId = GenderSerializer()

    class Meta:
        model = user
        fields = '__all__'
        

class messegeListSerializer(serializers.ModelSerializer):
    workOrder = WorkOrder2Serializer()

    class Meta:
        model = Message
        fields = '__all__'
        
class workOrderAssigmentJoinSerializer(serializers.ModelSerializer):
    workOrderId = WorkOrder2Serializer()

    class Meta:
        model = workOrderAssigment
        fields = '__all__'

class ComplaintJoinSerializer(serializers.ModelSerializer):
    clientId = userjoinSerializer()
    class Meta:
        model = workOrder2
        fields = '__all__' 

class ComplaintSerializer(serializers.ModelSerializer):
    workOrderId = ComplaintJoinSerializer()
    contractorId=userjoinSerializer()

    class Meta:
        model = workOrderAssigment
        fields = '__all__' 