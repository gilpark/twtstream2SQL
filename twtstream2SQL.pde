//twitter
String OAuthConsumerKey = "";
String OAuthConsumerSecret = "";
String AccessToken = "";
String AccessTokenSecret = "";
//SQL
String sql_user     = "";
String sql_pass     = "";
String sql_database = "";
String sql_address = "";

GetStream stream;
SQLdb db;
void setup() {
  //load twitter api key and SQL database info
  //config.csv header :
  //OAuthConsumerKey, OAuthConsumerSecret, AccessToken, AccessTokenSecret, sql_usr, sql_pass, sql_database, sql_address  
  Table config = loadTable("config2.csv","header");
  
  OAuthConsumerKey = config.getString(0,0);
  OAuthConsumerSecret = config.getString(0,1);
  AccessToken = config.getString(0,2);
  AccessTokenSecret = config.getString(0,3);
  
  sql_user = config.getString(0,4);
  sql_pass = config.getString(0,5);
  sql_database = config.getString(0,6);
  sql_address = config.getString(0,7);
  
  stream = new GetStream();
  db = new SQLdb(this);
}

