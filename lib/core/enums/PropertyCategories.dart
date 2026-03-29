enum PropertyCategories {
  villa(id: '1', displayName: "Villa"),
  apartment(id: '2', displayName: "Apartment"),
  houses(id: '3', displayName: "House"),
  office(id: '4', displayName: "Office"),
  shop(id: '5', displayName: "Shop"),
  garage(id: '6', displayName: "Garage"),
  studio(id: '7', displayName: "Studio"),
  all(id: '8', displayName: "All");

  final String id;
  final String displayName;
  const PropertyCategories({required this.id, required this.displayName});
}
