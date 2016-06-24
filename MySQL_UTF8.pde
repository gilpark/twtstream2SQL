public class MySQL_UTF8 extends SQL
{  
  public MySQL_UTF8 ( PApplet _papplet, String _database )
  {
    // should not be used
  }
  

  public MySQL_UTF8 (  PApplet _papplet, String _server, String _database, String _user, String _pass)
  {
    super( _papplet, _server, _database, _user, _pass );
    init();
  }
  
  private void init ()
  {
    this.driver = "com.mysql.jdbc.Driver";
    this.type = "mysql";
    
    this.url = "jdbc:" + type + "://" + server +  "/" + database + "?useUnicode=yes&characterEncoding=UTF-8";
   
  }
  
  public String[] getTableNames ()
  {
    if ( tableNames == null ) 
    {
      tableNames = new ArrayList<String>();
      query( "SHOW TABLES" );
      while ( next() ) {
        tableNames.add( getObject("Tables_in_"+database).toString() );
      }
    }
    return tableNames.toArray(new String[0]);
  }
}
