class Constants {
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0cTYwTWs3R0poeXg5IiwibmFtZSI6Ik5hcmVzaCIsImlhdCI6MTY2Mzc1MjEzNCwiZXhwIjoxNjY2MzQ0MTM0fQ.CtfnZC3Y58YcoLCD29v8Fjz24kQUeUfViDx6ukGJPFw';
  static const String baseUrl = 'https://devapi.wtfup.me/';

  static String getData(
          {required int page,
          required int limit,
          required double lat,
          required double lng}) =>
      '${baseUrl}gym/nearestgym/new?page=$page&limit=$limit&lat=$lat&long=$lng';
}
