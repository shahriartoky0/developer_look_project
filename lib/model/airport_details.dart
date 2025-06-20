class AirportDetails {
  String? code;
  String? lat;
  String? lon;
  String? name;
  String? city;
  String? state;
  String? country;
  String? woeid;
  String? tz;
  String? phone;
  String? type;
  String? email;
  String? url;
  String? runwayLength;
  String? elev;
  String? icao;
  String? directFlights;
  String? carriers;

  AirportDetails({
    this.code,
    this.lat,
    this.lon,
    this.name,
    this.city,
    this.state,
    this.country,
    this.woeid,
    this.tz,
    this.phone,
    this.type,
    this.email,
    this.url,
    this.runwayLength,
    this.elev,
    this.icao,
    this.directFlights,
    this.carriers,
  });

  // Factory method to create an Airport object from JSON
  factory AirportDetails.fromJson(Map<String?, dynamic> json) {
    return AirportDetails(
      code: json['code'],
      lat: json['lat'],
      lon: json['lon'],
      name: json['name'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      woeid: json['woeid'],
      tz: json['tz'],
      phone: json['phone'] ?? '',
      type: json['type'],
      email: json['email'] ?? '',
      url: json['url'] ?? '',
      runwayLength: json['runway_length'],
      elev: json['elev'],
      icao: json['icao'],
      directFlights: json['direct_flights'],
      carriers: json['carriers'],
    );
  }

  // Method to convert Airport object to JSON
  Map<String?, dynamic> toJson() {
    return {
      'code': code,
      'lat': lat,
      'lon': lon,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'woeid': woeid,
      'tz': tz,
      'phone': phone,
      'type': type,
      'email': email,
      'url': url,
      'runway_length': runwayLength,
      'elev': elev,
      'icao': icao,
      'direct_flights': directFlights,
      'carriers': carriers,
    };
  }
}
