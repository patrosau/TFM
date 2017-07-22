import sys
import psycopg2

class DB_Helper:
    def __init__(self, host, database, user, password):
        self.host = host
        self.database = database
        self.user = user
        self.password = password
        self.connstr = "host='%s' dbname='%s' user='%s' password='%s'" % (self.host, self.database, self.user, self.password)

    def checkConnection(self):
        try:
            dbConnection = psycopg2.connect(self.connstr)
            dbConnection.close()
            return 1
        except:
            return 0
    def connect(self):
        self.conn = psycopg2.connect(self.connstr)
    def close(self):
        self.conn.close();

    def saveTweet(self, tweetFields):
        cur = self.conn.cursor()
        SQL = "INSERT INTO maps.tweets (id, tweet, x, y, hourslot, favourite_count,\
         retweet_count, in_reply_to, quoted_status_id, retweeted_status_id, user_id, geom) \
         VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, st_setsrid(st_point(%s,%s), 3857));"  # Note: no quotes
        data = (tweetFields['id'],tweetFields['tweet'], tweetFields['x'], tweetFields['y'], \
                tweetFields['hourslot'], tweetFields['favourite_count'], \
                tweetFields['retweet_count'], tweetFields['in_reply_to'], \
                tweetFields['quoted_status_id'], tweetFields['retweeted_status_id'], \
                tweetFields['user_id'],tweetFields['x'], tweetFields['y'])
        cur.execute(SQL, data)  # Note: no % operator
        self.conn.commit()



