class Address {
  String? addressLine1;
  String? addressLine2;
  String? pincode;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  bool isActive;
  bool isAssigned;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.pincode,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.isActive = false,
    this.isAssigned=false,
  });
  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'pincode': pincode,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'isAssigned':isAssigned,
    };
  }
}
