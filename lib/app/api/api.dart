class Api {
  static String ipConfig = "http://" + "192.168.0.103";

  static String loginUrl = ipConfig + "/hellogram/login";
  static String getUrl = ipConfig + "/hellogram/getpost.php";

  static String getPostUrl = ipConfig + "/hellogram/posts";
  static String registerUrl = ipConfig + "/hellogram/register";
  static String getImageUrl = ipConfig + "/hellogram/image?post_id=";
  static String getUserUrl = ipConfig + "/hellogram/user?user_id=";
  static String getProfileImgUrl =
      ipConfig + "/hellogram/profile_image?user_id=";

  static String onLikeUrl = ipConfig + "/hellogram/like?";

  static String countLikeUrl = ipConfig + "/hellogram/countlike?post_id=";

  static String onLikeCheckUrl = ipConfig + "/hellogram/likecheck?";

  static String imageUrl = ipConfig + "/hellogram/";
}
