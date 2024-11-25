enum City {
  Abbottabad,
  Bajaur,
  Bannu,
  Batagram,
  Buner,
  Charsadda,
  Dera_Ismail_Khan,
  Hangu,
  Haripur,
  Karak,
  Khyber,
  Kohat,
  Kolai_Pallas,
  Kurram,
  Lakki_Marwat,
  Lower_Chitral,
  Lower_Dir,
  Lower_Kohistan,
  Malakand,
  Mansehra,
  Mardan,
  Mohmand,
  North_Waziristan,
  Nowshera,
  Orakzai,
  Peshawar,
  Shangla,
  South_Waziristan,
  Swabi,
  Swat,
  Tank,
  Tor_Ghar,
  Upper_Chitral,
  Upper_Dir,
  Upper_Kohistan
}

extension CityName on City {
  String get nameR {
    return toString().split('.').last.replaceAll('_', ' ');
  }
}
