class Api {
  static String ipConfig = "192.168.0.103";

  static String loginUrl = "http://" + ipConfig + "/hellogram/login";
  static String getUrl = "http://" + ipConfig + "/hellogram/getpost.php";

  static String getPostUrl = "http://" + ipConfig + "/hellogram/posts";
  static String registerUrl = "http://" + ipConfig + "/hellogram/register";
  static String getImageUrl =
      "http://" + ipConfig + "/hellogram/image?post_id=";
  static String getUserUrl = "http://" + ipConfig + "/hellogram/user?user_id=";
  static String getProfileImgUrl =
      "http://" + ipConfig + "/hellogram/profile_image?user_id=";
  static String onLikeUrl = "http://" + ipConfig + "/hellogram/like?";

  static String countLikeUrl =
      "http://" + ipConfig + "/hellogram/countlike?post_id=";

  static String onLikeCheckUrl = "http://" + ipConfig + "/hellogram/likecheck?";

  static String imageUrl = "http://" + ipConfig + "/hellogram/";
}
