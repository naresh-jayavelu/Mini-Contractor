from django.contrib import admin

# Register your models here.
from .models import role,user,contractorWorkProfiles,gender,address,document,documentType,jobType,documentMapping,expertise,WorkOrderMessage,Message, workOrder2,workOrderInvoice,workOrderAssigment,searchResult,search,serviceRequest,review,workOrderProgress,workOrderContractorPreference,contractorWorkProfileRequest,workOrder

admin.site.register(workOrder2)
admin.site.register(role)
admin.site.register(documentMapping)
admin.site.register(user)
admin.site.register(contractorWorkProfiles)
admin.site.register(gender)
admin.site.register(address)
admin.site.register(document)
admin.site.register(documentType)
admin.site.register(jobType)
admin.site.register(expertise)

admin.site.register(workOrder)
admin.site.register(workOrderContractorPreference)
admin.site.register(review)
admin.site.register(searchResult)
admin.site.register(workOrderAssigment)
admin.site.register(contractorWorkProfileRequest)
admin.site.register(workOrderInvoice)
admin.site.register(Message)
admin.site.register(WorkOrderMessage)