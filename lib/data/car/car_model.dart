class CarModel {
  String? brandLogo;
  String? carBrand;
  String? carEnginePower;
  String? carFuelTankCapacity;
  String? carFuelType;
  String? carIcon;
  List<dynamic> carImages;
  List<dynamic> carLiked;
  String? carLocation;
  String? carMaxTorque;
  String? carName;
  String? carOwner;
  String? carPrice;
  String? carRange;
  String? carRating;
  String? carWheelType;
  String? carCurrentFuelCapacity;
  String? carSeatingCapacity;
  String? carTransmission;
  int carRentPricePerDay;
  int carRentTax;

  CarModel(
      {required this.brandLogo,
      required this.carBrand,
      required this.carEnginePower,
      required this.carFuelTankCapacity,
      required this.carFuelType,
      required this.carIcon,
      required this.carImages,
      required this.carLiked,
      required this.carLocation,
      required this.carMaxTorque,
      required this.carName,
      required this.carOwner,
      required this.carPrice,
      required this.carRange,
      required this.carRating,
      required this.carWheelType,
      required this.carCurrentFuelCapacity,
      required this.carSeatingCapacity,
      required this.carTransmission,
      required this.carRentPricePerDay,
      required this.carRentTax});
}
