class Meta {
  int currentPage;
  int lastPage;

  Meta(
      {required this.currentPage,
        required this.lastPage,
   });

  bool getIsLastPage(){
   if(currentPage==lastPage){
     return true;
   }else{
     return false;
   }
  }

  @override
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
        currentPage: json['current_page'],
        lastPage: json['last_page'],
     );
  }
}