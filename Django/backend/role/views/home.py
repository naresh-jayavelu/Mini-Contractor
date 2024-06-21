from django.shortcuts import render

from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.http import HttpResponse,JsonResponse

from backend.role.serializer import WorkOrderSerializer
from .. models import user,workOrder

@api_view(['GET'])
def home(request,id=0):
    workorders = workOrder.objects.all()
    context = WorkOrderSerializer(workorders,many=True)
    return JsonResponse(context,safe=False)
    
@api_view(['Post'])
def home(request):
    workorders = workOrder.objects.all()
    context = list(workorders.values())
    return JsonResponse(context,safe=False)
    

@api_view(['GET'])
def roles(request):
    roles=user.objects.all()
    context=list(roles.values())
    return Response(context)
    return JsonResponse({'roles': list(roles.values())})
