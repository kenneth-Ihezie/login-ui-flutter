class HttpResponse{
  final String status;
  final String data;

  HttpResponse({this.status, this.data});

  factory HttpResponse.fromJson(Map<String, String> json){
    return HttpResponse(
      status: json['status'],
      data: json['data']
    );
  }
}