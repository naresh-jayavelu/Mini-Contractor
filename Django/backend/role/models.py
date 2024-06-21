from datetime import datetime
from django.db import models
import uuid 
# Create your models here.
class role(models.Model):
    RoleCode=models.CharField(max_length=50,null=True)
    RoleName=models.CharField(max_length=50,null=True)
    RoleDescription=models.CharField(max_length=200,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    id=models.UUIDField(primary_key=True,default=uuid.uuid4)

    def __str__(self) -> str:
        return self.RoleCode
    
class gender(models.Model):
    genderCode=models.CharField(max_length=50,blank=True,null=True)
    genderName=models.CharField(max_length=50,blank=True,null=True)
    genderDescription=models.CharField(max_length=200,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    genderId=models.UUIDField(primary_key=True,default=uuid.uuid4)

    def __str__(self) -> str:
        return self.genderCode

class documentType(models.Model):
    documentTypeId=models.UUIDField(primary_key=True,default=uuid.uuid4)
    code=models.CharField(max_length=50,blank=True,null=True)
    name=models.CharField(max_length=50,blank=True,null=True)
    discription=models.CharField(max_length=50,blank=True,null=True)
    isActive=models.BooleanField(default=True)

    def __str__(self) -> str:
        return self.code

class document(models.Model):
    documentId=models.UUIDField(primary_key=True,default=uuid.uuid4)
    file=models.CharField(max_length=2000000 ,blank=True,null=True)
    documentTypeId=models.ForeignKey(documentType,on_delete=models.CASCADE,blank=True,null=True)
    isActive=models.BooleanField(default=True)

    def __str__(self) -> str:
        return str(self.documentId)


class jobType(models.Model):
    jobTypeCode=models.CharField(max_length=50,blank=True,null=True)
    jobTypeName=models.CharField(max_length=50,blank=True,null=True)
    jobTypeDescription=models.CharField(max_length=200,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    jobTypeId=models.UUIDField(primary_key=True,default=uuid.uuid4)

    def __str__(self) -> str:
        return self.jobTypeCode


class expertise(models.Model):
    expertiseCode=models.CharField(max_length=50,blank=True,null=True)
    expertiseName=models.CharField(max_length=50,blank=True,null=True)
    expertiseDescription=models.CharField(max_length=200,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    expertiseId=models.UUIDField(primary_key=True,default=uuid.uuid4)

    def __str__(self) -> str:
        return self.expertiseCode


class address(models.Model):
    addressLine1=models.CharField(max_length=100,blank=True,null=True)
    addressLine2=models.CharField(max_length=100,blank=True,null=True)
    pincode=models.CharField(max_length=20,blank=True,null=True)
    city=models.CharField(max_length=50,blank=True,null=True)
    state=models.CharField(max_length=50,blank=True,null=True)
    country=models.CharField(max_length=50,blank=True,null=True)
    latitude=models.CharField(max_length=200,blank=True,null=True)
    longitude=models.CharField(max_length=200,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    addressId=models.UUIDField(primary_key=True,default=uuid.uuid4)

    def __str__(self) -> str:

        return str(self.addressId)


class user(models.Model):
    userId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    email=models.CharField(max_length=50,blank=True,null=True)
    firstName=models.CharField(max_length=50,blank=True,null=True)
    lastName=models.CharField(max_length=50,blank=True,null=True)
    password=models.CharField(max_length=50,blank=True,null=True)
    dob=models.CharField(max_length=50,blank=True,null=True)
    phone=models.CharField(max_length=50,blank=True,null=True)
    status=models.CharField(max_length=50,blank=True,null=True)
    isActive=models.BooleanField(default=True)
    roolId=models.ForeignKey(role,on_delete=models.CASCADE,blank=True,null=True)
    addressId=models.ForeignKey(address,on_delete=models.CASCADE,blank=True,null=True)
    genderId=models.ForeignKey(gender,on_delete=models.CASCADE,blank=True,null=True)

    def __str__(self) -> str:
        return self.email

class documentMapping(models.Model):
    documentMappingId = models.UUIDField(primary_key=True, default=uuid.uuid4, null=False, blank=True)
    documentId = models.ForeignKey(document, on_delete=models.CASCADE,blank=True,null=True)
    entityType = models.ForeignKey(role, on_delete=models.CASCADE,blank=True,null=True)
    entityId = models.ForeignKey(user, on_delete=models.CASCADE,blank=True,null=True)
    isActive = models.BooleanField(default=True)
    
    def __str__(self) -> str:
        return str(self.entityType)  

# dummy table
# class contractorWorkProfile(models.Model):
#     contractorWorkProfileId = models.UUIDField(primary_key=True, default=uuid.uuid4, null=False, blank=True)
#     # contractorId = models.ForeignKey(user, on_delete=models.CASCADE,blank=True)
#     # jobTypeId = models.ForeignKey(jobType, on_delete=models.CASCADE,blank=True)
#     # expertiseId = models.ForeignKey(expertise, on_delete=models.CASCADE,blank=True)
#     # documentMappingId = models.ForeignKey(documentMapping, on_delete=models.CASCADE,blank=True)
#     isActive = models.BooleanField(default=True)

#     def __str__(self) -> str:
#         return str(self.isActive)
    
class contractorWorkProfiles(models.Model):
    contractorWorkProfileId = models.UUIDField(primary_key=True, default=uuid.uuid4, null=False, blank=True)
    contractorId = models.ForeignKey(user, on_delete=models.CASCADE,blank=True,null=True)
    jobTypeId = models.ForeignKey(jobType, on_delete=models.CASCADE,blank=True,null=True)
    expertiseId = models.ForeignKey(expertise, on_delete=models.CASCADE,blank=True,null=True)
    documentId = models.ForeignKey(document, on_delete=models.CASCADE,blank=True,null=True)
    isActive = models.BooleanField(default=True)

    def __str__(self) -> str:
        return str(self.isActive)

class workOrder(models.Model):
    Id=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    description=models.CharField(max_length=50,blank=True,null=True)
    estimatedAmount=models.CharField(max_length=50,blank=True,null=True)
    status=models.CharField(max_length=50,blank=True,null=True)
    estimatedStartDate=models.CharField(max_length=100,blank=True,null=True)
    estimatedEndDate=models.CharField(max_length=100,blank=True,null=True)
    documentMappingID=models.ForeignKey(documentMapping,on_delete=models.CASCADE,blank=True,null=True)
    jobTypeId=models.ForeignKey(jobType,on_delete=models.CASCADE,blank=True,null=True)
    expertiseId=models.ForeignKey(expertise,on_delete=models.CASCADE,blank=True,null=True)
    addressId=models.ForeignKey(address,on_delete=models.CASCADE,blank=True,null=True)
    isAssigned = models.BooleanField(default=True)
    isActive = models.BooleanField(default=True)

    def __str__(self) -> str:
        return self.description
    

class workOrder2(models.Model):
    Id=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    description=models.CharField(max_length=50,blank=True,null=True)
    estimatedAmount=models.CharField(max_length=50,blank=True,null=True)
    status=models.CharField(max_length=50,blank=True,null=True)
    estimatedStartDate=models.CharField(max_length=100,blank=True,null=True)
    estimatedEndDate=models.CharField(max_length=100,blank=True,null=True)
    document=models.ForeignKey(document,on_delete=models.CASCADE,blank=True,null=True)
    jobTypeId=models.ForeignKey(jobType,on_delete=models.CASCADE,blank=True,null=True)
    expertiseId=models.ForeignKey(expertise,on_delete=models.CASCADE,blank=True,null=True)
    clientId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    addressId=models.ForeignKey(address,on_delete=models.CASCADE,blank=True,null=True)
    isAssigned = models.BooleanField(default=True)
    isActive = models.BooleanField(default=True)

    def __str__(self) -> str:
        return self.description
    
class workOrderContractorPreference(models.Model):
    workOrderContractorPreferenceId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOrderId=models.ForeignKey(workOrder,on_delete=models.CASCADE,blank=True,null=True)
    ContractorId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    def __str__(self) -> str:
        return self.workOrderContractorPreferenceId

class workOrderProgress(models.Model):
    workOrderProgressId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOworkOrderrderId=models.ForeignKey(workOrder,on_delete=models.CASCADE,blank=True,null=True)
    actionedOn=models.CharField(max_length=50,blank=True,null=True)
    status=models.CharField(max_length=50,blank=True,null=True)
    completedPercentage=models.CharField(max_length=50,blank=True,null=True)

    def __str__(self) -> str:
        return self.workOrderProgressId

class review(models.Model):
    reviewId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    entityType=models.ForeignKey(role,on_delete=models.CASCADE,blank=True,null=True)
    entityId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    workOrderId=models.ForeignKey(workOrder2,on_delete=models.CASCADE,blank=True,null=True)
    rating=models.CharField(max_length=50,blank=True,null=True)
    comment=models.CharField(max_length=50,blank=True,null=True)

    def __str__(self) -> str:
        return self.comment

class serviceRequest(models.Model):
    serviceRequestId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOrderId=models.ForeignKey(workOrder,on_delete=models.CASCADE,blank=True,null=True)
    userId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    title=models.CharField(max_length=50,blank=True,null=True)
    discription=models.CharField(max_length=50,blank=True,null=True)

    def __str__(self) -> str:
        return self.title

class search(models.Model):
    searchId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOrderId=models.ForeignKey(workOrder,on_delete=models.CASCADE,blank=True,null=True)
    searchCommand=models.CharField(max_length=50,blank=True,null=True)
    status=models.CharField(max_length=50,blank=True,null=True)
    searchStartedOn=models.CharField(max_length=100,blank=True,null=True)
    searchEndedOn=models.CharField(max_length=100,blank=True,null=True)

    def __str__(self) -> str:
        return self.workOrderId



class searchResult(models.Model):
    serviceRequestId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    searchId=models.ForeignKey(search,on_delete=models.CASCADE,blank=True,null=True)
    contractorId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)

    def __str__(self) -> str:
        return self.searchId

class workOrderAssigment(models.Model):
    workOrderAssigmentId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOrderId=models.ForeignKey(workOrder2,on_delete=models.CASCADE,blank=True,null=True)
    contractorId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    requestStatus=models.CharField(max_length=100,blank=True,null=True)
    responseStatus=models.CharField(max_length=100,blank=True,null=True)

    def __str__(self) -> str:
        return str(self.workOrderAssigmentId)
    
class contractorWorkProfileRequest(models.Model):
    contractorWorkProfileRequestId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    contractorId=models.ForeignKey(user,on_delete=models.CASCADE,blank=True,null=True)
    Status=models.CharField(max_length=100,blank=True,null=True)
    comment=models.CharField(max_length=100,blank=True,null=True)

    def __str__(self) -> str:
        return self.Status
    

class workOrderInvoice(models.Model):
    workOrderInvoiceId=models.UUIDField(primary_key=True,default=uuid.uuid4,blank=True)
    workOrderId=models.ForeignKey(workOrder,on_delete=models.CASCADE,blank=True,null=True)
    totalAmount=models.CharField(max_length=50,blank=True,null=True)
    invoiveJson=models.CharField(max_length=500,blank=True,null=True)

    def __str__(self) -> str:
        return self.workOrderInvoiceId



class Message(models.Model):
    messageId = models.UUIDField(primary_key=True, default=uuid.uuid4, blank=True)
    text = models.CharField(max_length=100, blank=True,null=True)
    actionedOn = models.ForeignKey(user, on_delete=models.CASCADE, blank=True, related_name='actioned_messages',null=True)
    documentId = models.ForeignKey(document, on_delete=models.CASCADE, blank=True,null=True)
    userId = models.ForeignKey(user, on_delete=models.CASCADE, blank=True, related_name='user_messages',null=True)
    workOrder = models.ForeignKey(workOrder2, on_delete=models.CASCADE, blank=True, related_name='user_messages',null=True)
    time2 = models.DateTimeField(default=datetime.now)
    
    def __str__(self) -> str:
        return self.text


class WorkOrderMessage(models.Model):
    workOrderMessageId = models.UUIDField(primary_key=True, default=uuid.uuid4, blank=True)
    workOrderId = models.ForeignKey(workOrder, on_delete=models.CASCADE, blank=True,null=True)
    messageId = models.ForeignKey(Message, on_delete=models.CASCADE, blank=True,null=True)
    
    def __str__(self) -> str:
        return str(self.workOrderMessageId)

