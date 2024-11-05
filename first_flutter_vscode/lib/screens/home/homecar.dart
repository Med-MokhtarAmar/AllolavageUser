// lib/model/homecar.dart

/// Represents a car with basic properties like brand, model, and size.
class HomeCar {
  // Car properties
  final String ServicePren;
  final String model;
  final int prix;
  final String images;

  // Constructor
  HomeCar({
    required this.ServicePren,
    required this.model,
    required this.prix,
    required this.images,
  });
}

/// Enum for car size to avoid using plain strings
// enum CarSize { petit, moyenne, grand }

List<HomeCar> carList = [
  HomeCar(images: 'images/lavage3.jpg' , ServicePren: "lavage avec brossage", model: "TX", prix:200 ),
  HomeCar(images: 'images/lavage3.jpg' , ServicePren: "lavage sans brossage", model: "V8", prix: 200),
  HomeCar(images: 'images/lavage4.jpg' , ServicePren: "lavage avec brossage", model: "Corolla", prix: 150),
  HomeCar(images: 'images/lavage4.jpg' , ServicePren: "lavage avec brossage", model: "RV4", prix: 150),
  HomeCar(images: 'images/lavage4.jpg' , ServicePren: "lavage sans brossage", model: "V6", prix: 200),
];



class HomeService {
  // Car properties
  final String Service;
  final String images;

  // Constructor
   HomeService({
    required this.Service,
    required this.images,
  });
}

List<HomeService> ServiceList = [
  HomeService(images: 'images/logo.png' , Service:"Services Principales"),
  HomeService(images: 'images/logo.png' , Service:"Services Supplémentaires"),
];