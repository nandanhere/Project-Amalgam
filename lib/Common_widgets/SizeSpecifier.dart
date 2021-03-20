DeviceType widthdecider(double w) {
  if (w < 650) {
    return DeviceType.Mobile;
  } else if (w > 650 && w < 900) {
    return DeviceType.Tablet;
  }
  return DeviceType.Web;
}

enum DeviceType { Mobile, Tablet, Web }
double returner(DeviceType type, double h1, double h2, double h3) {
  // print(type.toString());
  if (DeviceType.Mobile == type) {
    return h1;
  } else if (DeviceType.Tablet == type) {
    return h2;
  }
  return h3;
}
