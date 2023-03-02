class IconUtils {

  static const assetsUrl = 'assets/weatherly/';

  static String getIconUrl(String icon) {
    switch (icon) {
      case '01d':
        return '${assetsUrl}sun.png';
      case '01n':
        return '${assetsUrl}moon.png';
      case '02d':
        return '${assetsUrl}sun_cloud.png';
      case '02n':
        return '${assetsUrl}moon_cloud.png';
      case '03d':
        return '${assetsUrl}cloud.png';
      case '03n':
        return '${assetsUrl}cloud.png';
      case '04d':
        return '${assetsUrl}cloud_ittle_snow.png';
      case '04n':
        return '${assetsUrl}cloud_ittle_snow.png';
      case '09d':
        return '${assetsUrl}cloud_angled_rain.png';
      case '09n':
        return '${assetsUrl}cloud_angled_rain.png';
      case '10d':
        return '${assetsUrl}sun_cloud_angled_rain.png';
      case '10n':
        return '${assetsUrl}moon_cloud_angled_rain.png';
      case '11d':
        return '${assetsUrl}cloud_3_zap.png';
      case '11n':
        return '${assetsUrl}cloud_3_zap.png';
      case '13d':
        return '${assetsUrl}big_snow_little_snow.png';
      case '13n':
        return '${assetsUrl}big_snow_little_snow.png';
      case '50d':
        return '${assetsUrl}slow_winds.png';
      case '50n':
        return '${assetsUrl}slow_winds.png';
      default:
        return '';
    }
  }
}
