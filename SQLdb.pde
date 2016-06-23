//  @TODO : get images in tweets ref: http://twitter4j.org/javadoc/twitter4j/User.html
//  @TODO : get/restore unicode text

/*
  SQLdb()
  connect to a remote SQL database
  build querys to add records to DB
*/

//import de.bezier.data.sql.*;
import java.util.*;
import java.sql.*;

class SQLdb {
  MySQL msql;
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //SQL datetime format

  SQLdb(PApplet p) {
    msql = new MySQL( p, sql_address, sql_database, sql_user, sql_pass );
    if ( msql.connect() ) {
      println("connected");
    } else {
      println("failed to connect!");
    }
  }
  /* data base structure
   table: tweets
   --------------------------------------------------------------------------------------------------------------------------
   |tweet_id   | tweet_text  |created_at|geo_lat|geo_long|  user_id  |screen_name|   name     |profile_image_url|  is_rt    |
   --------------------------------------------------------------------------------------------------------------------------
   | bigint(20)| varchar(160)| datetime |double | double | bigint(20)| char(20)  | varchar(20)| varchar(200)    | tinyint(1)|
   --------------------------------------------------------------------------------------------------------------------------
   table: users
   ---------------------------------------------------------------------------------------------------------------------------------------
   | user_id  |screen_name|   name    |profile_image_url|  location   |     url    |description |created_at|followers_count|friends_count|
   ---------------------------------------------------------------------------------------------------------------------------------------
   |bigint(20)|varchar(20)|varchar(20)|   varchar(200)  | varchar(30) |varchar(200)|varchar(200)| datetime |    int(10)    |   int(10)   |
   ---------------------------------------------------------------------------------------------------------------------------------------    
   */
  void addRec(Status s) {
    //add record to tweets table
    String qr1 = "INSERT INTO tweets(tweet_id,tweet_text,created_at,geo_lat,geo_long,user_id, screen_name, name, profile_image_url) VALUES (";
    qr1 += s.getId() + ",'" +
      msg(s.getText()) + "','" +
      sdf.format(s.getCreatedAt())+"'," + 
      s.getGeoLocation().getLatitude() + ","+
      s.getGeoLocation().getLongitude() + ","+
      s.getUser().getId() + ",'"+
      s.getUser().getScreenName() + "','"+
      s.getUser().getName() + "','"+
      s.getUser().getMiniProfileImageURL() + "')";

    String qr2 = "INSERT INTO users(user_id, screen_name, name, profile_image_url, location, url, description, created_at, followers_count, friends_count) VALUES (";
    qr2 += s.getUser().getId() + ",'"+
      s.getUser().getScreenName() + "','"+
      s.getUser().getName() + "','"+
      s.getUser().getMiniProfileImageURL() + "','"+
      s.getUser().getLocation() + "','"+
      s.getUser().getURL() + "','"+
      s.getUser().getDescription() + "','"+
      sdf.format(s.getUser().getCreatedAt())+ "',"+
      s.getUser().getFollowersCount() + ","+
      s.getUser().getFriendsCount() + ")";

    if ( msql.connect()) {
      msql.query(qr1); //query to tweets table
      msql.query(qr2); //query to users table
    }
  }
  //get rid of url in tweets
  String msg (String text) {
    text = text.replaceAll("((https?|ftp|gopher|telnet|file|Unsure|http):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\\\.&]*)", "");
    text = text.replace("'", "");
    text = text.replaceAll("@\\w+", "");
    text = text.replaceAll("RT+", "");
    text = text.replace("\\.+", ".");
    text = text.replace("!!+", "!");
    text = text.replace("??+", "?");
    text = text.replace("#\\w+", "");

    return text;
  }
}

