//twitter4j code examples : http://twitter4j.org/en/code-examples.html
//@TODO : multiLang suport (unicode)

/*
  GetStream()
  connect to twitter streaming api
  pass Status(tweet+usr) obj to SQLdb class
*/

class GetStream {
  
  ConfigurationBuilder cb;
  TwitterStream twitterStream; 

  //streaming api listener
  StatusListener listener = new StatusListener() {
    @Override
      public void onStatus(Status status) {

      //filltering by geolocation & language
      if (status.getGeoLocation() != null && status.getLang().equals("en")){     
        db.addRec(status);
      }  
    }
    @Override
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      // System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
    }

    @Override
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      //System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
    }
    @Override
      public void onScrubGeo(long userId, long upToStatusId) {
      //System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }
    @Override
      public void onStallWarning(StallWarning warning) {
      //System.out.println("Got stall warning:" + warning);
    }
    @Override
      public void onException(Exception ex) {
      ex.printStackTrace();
    }
  };

  GetStream() {
    cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey(OAuthConsumerKey);
    cb.setOAuthConsumerSecret(OAuthConsumerSecret);
    cb.setOAuthAccessToken(AccessToken);
    cb.setOAuthAccessTokenSecret(AccessTokenSecret);    
    twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
    twitterStream.addListener(listener);
    twitterStream.sample();
  }
}

