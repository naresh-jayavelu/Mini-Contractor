from django.urls import path,include

from . import views
# from .views import home

urlpatterns = [
    path('',views.jobTypeApi),
    path('jobType',views.jobTypeApi),
    path('jobType/<str:id>/',views.jobTypeApi),
    path('expertise',views.expertiseApi),
    path('address',views.addressApi),
    path('roles/',views.roles),
    path('mix',views.mix),
    path('role/<str:pk>',views.role),
    path('home/',views.home),
    path('workorder',views.workOrderApi),
    path('workorder/<str:id>/',views.workOrderApi),
    path('workorderJoin',views.workorderJoinApi),
    path('workorderJoin/<str:id>/',views.workorderJoinApi,name='workorderJoin'),
    path('login/', views.loginApi,name='login'),
    path('messagesend',views.MessageApi,name='messagesend'),
    path('document',views.documentApi),
    path('address',views.addressApi),
    path('user',views.useraddApi),
    path('contractor',views.contractoraddApi),
    path('getuser',views.userApi),
    path('workorder2',views.workOrder2Api),
    path('workOrderAssigment',views.workOrderAssigmentApi,name='workOrderAssigment'),
    path('workOrderAssigments/<str:id>/<str:type>/',views.workOrderAssigmentsApi),
    path('messege/<str:id>/',views.MessageListApi),
    path('orderMessege/<str:id>/<str:userId>/', views.MessageDataApi),
    path('isFirst/<str:id>/<str:userId>/', views.isFirstApi),
    path('acceptRequest/<str:id>/',views.acceptRequestApi),
    path('review/<str:id>/<str:type>/', views.reviewsApi),
    path('updateRequest/<str:id>/<str:val>/',views.updateRequestApi),
    path('addReview',views.reviewUpdateApi),
    path('gender',views.genderApi),
    path('user/<str:id>/',views.userApi),
    path('userupdate/<str:id>/<str:type>/<str:data>/',views.userupdateApi),
    path('workOrderUpdate/<str:id>/<str:type>/<str:data>/',views.workOrderUpdateApi),
    path('complaints',views.complaintsApi),
    path('block/<str:id>/',views.blockuserApi),
    path('closeComplaint/<str:id>/',views.closecomplaintApi),
    path('contractorDocumentUpload',views.documentUpdateApi),
    path('contractorLogin', views.contractor_login_api),
    path('removeWorkOrder/<str:contractorWorkProfileId1>', views.contractorProfileRemoveApi),
    path('checks/<str:email>/<str:password>/<str:jobtype>/<str:expertiseType>',views.extraApi),
    path('profile',views.profileApi),
    # path('user',views.userApi),
    
]
def chech(request):
    print("haha")
    return