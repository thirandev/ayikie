class Common{
  static String getImage({required String imageName}){
    return "https://ayikie.cyberelysium.app/uploads/" + imageName;
  }
  static String getThumbnail({required String imageName}){
    return "https://ayikie.cyberelysium.app/uploads/thumb/" + imageName;
  }
}