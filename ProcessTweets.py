import DatabaseUtils
import DirectoryUtils
import ProjUtils
import json
import math
from dateutil import parser

db = DatabaseUtils.DB_Helper('127.0.0.1', 'gisdb', 'postgres', '****')
converter = ProjUtils.WGS84_WebMercatorConverter()
#print (db.checkConnection())

tweetFields = {'id': 'id', \
               'tweet':'text', \
               'hourslot':'created_at', \
               'favourite_count' : 'favorite_count', \
               'retweet_count' : 'retweet_count', \
               'in_reply_to' : 'in_reply_to_status_id', \
               'quoted_status_id' : 'quoted_status_id', \
               'retweeted_status_id' : 'retweeted_status', \
               'user_id': 'user'}

directory = DirectoryUtils.directoryHelper('/root/Downloads/TFM-BigData/')

def GetMercatorCoordinates(coordinates):
    if (coordinates is not None):
        longitude = coordinates['coordinates'][0]
        latitude = coordinates['coordinates'][1]
        try:
            point = converter.Transform(longitude, latitude)
            return point
        except:
            return None
    else:
        return None

def GetTimeslot(utcDataString):
    if (utcDataString is not None):
        date = parser.parse(utcDataString)
        timeslot = date.year * 1000000 + \
            date.month * 10000 + \
            date.day * 100 + \
            date.hour
        return timeslot
    else:
        return None

def GetRetweetId(retweetedStatus):
    if (retweetedStatus is not None):
        return retweetedStatus['id']
    else:
        return None

def GetUserId(user):
    if (user is not None):
        return user['id']
    else:
        return None

def processTweetField(fieldKey, fieldValue):
    if (fieldKey == 'hourslot'):
        return GetTimeslot(fieldValue)
    elif (fieldKey == 'retweeted_status_id'):
        return GetRetweetId(fieldValue)
    elif (fieldKey == 'user_id'):
        return GetUserId(fieldValue)
    else:
        return fieldValue


def processTweet(tweet):
    processDic = dict()
    if ('coordinates') in tweet:
        mercatorcoordinates = GetMercatorCoordinates(tweet['coordinates'])
        if mercatorcoordinates is not None:
            processDic['x'] = math.floor(mercatorcoordinates[0]/50)*50+25
            processDic['y'] = math.floor(mercatorcoordinates[1]/50)*50+25
            for dbField in tweetFields:
                if tweetFields[dbField] in tweet:
                    processDic[dbField] = processTweetField(dbField, tweet[tweetFields[dbField]])
                else:
                    processDic[dbField] = None
        else:
            return None
    return processDic


db.connect()
# for file in directory.getFiles():
with open('/root/Downloads/TFM-BigData/oscars_9.json') as json_file:
     list = json.load(json_file)
     for tweet in list:
         processedFields = processTweet(tweet)
         if processedFields is not None:
             db.saveTweet(processedFields)
db.close()
