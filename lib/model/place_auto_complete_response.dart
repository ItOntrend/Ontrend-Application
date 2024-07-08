// class PlaceAutoCompleteResponse {
//   final String? status;
//   final List<>? predictions;

//   PlaceAutoCompleteResponse({this.status,this.predictions,});
//   factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
//     return PlaceAutoCompleteResponse(
//       status: json['status'] as String?,
//       predictions: json['predictions'] != null ? json['Predictions'].map<>((json) => .fromJson(json)).toList() : null,
//     );
//   }


//   static PlaceAutoCompleteResponse placeAutoCompleteResult(
//     String responseBody
//   ){
//     final parsed = json.decode(responseBody).cast<String, dynamic>();

//     return PlaceAutoCompleteResponse.fromJson(parsed);
//   }
// }