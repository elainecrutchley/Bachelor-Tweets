# We use the package "streamR" which is designed to connect to the Twitter # Streaming API.
# Packages are loaded into R with the command library() 
library(streamR)
# In addition, we need the "ROAuth"-package to establish an 
# authentification.
library(ROAuth)
# The following four lines assign the right values to the variables that
# are needed for the API call.
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
# The string within the quotation marks has to be replaced with the actual
# consumerKey and consumerSecret.
consumerKey <- "0GH3WxtMJ1TdlynyCVx2wTKY8"
consumerSecret <- "pup4Yos93qGP20S7TMKEIQx0RpnowrRt3nBMXNyYabcfTRwNc6"
# The next two lines establish a connection to the Twitter API.
# The system will print a URL which should be copied in a browser to receive a PIN number.
# This PIN has to be entered in the R-console.
my_oauth <- OAuthFactory$new(consumerKey = consumerKey, 
                             consumerSecret = consumerSecret, 
                             requestURL = requestURL, 
                             accessURL = accessURL, 
                             authURL = authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
# Once the connection is established we can save it so that we do not have
# repeat this process.
save(my_oauth, file = "my_oauth.Rdata")

load("my_oauth.Rdata")

library(streamR)

filterStream( file.name="preshow_hr1.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

tweets_test.df <- parseTweets("tweets_test2.json")
tweets_test2.df <- parseTweets("tweets_test2.json")
tweets_test2.df

str(tweets_test2.df)
tweets_test2.df$location

filterStream( file.name="preshow_hr1.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

filterStream( file.name="preshow_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

filterStream( file.name="preshow_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

filterStream( file.name="preshow_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

filterStream( file.name="preshow_hr5.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

preshow_hr1.df <- parseTweets("preshow_hr1.json")
preshow_hr2_test.df <- parseTweets("preshow_hr2.json", simplify=TRUE)
str(preshow_hr2.df)
preshow_hr2.df$text
head(preshow_hr2.df)
preshow_hr3_test.df <- parseTweets("preshow_hr3.json", simplify=TRUE)
preshow_hr4.df <- parseTweets("preshow_hr4.json")
preshow_hr5.df <- parseTweets("preshow_hr5.json")

head(preshow_tweets)

preshow_tweets <- rbind(preshow_hr1.df, preshow_hr2.df, preshow_hr3.df, preshow_hr4.df, preshow_hr5.df)

preshow_tweets_subset <- preshow_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon")]

write.table(preshow_tweets_subset, file="preshow_tweets_subset2.txt", eol = "$$#%^&", sep="/t")

filterStream( file.name="show1_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show1_hr1.df <- parseTweets("show1_hr1.json")

filterStream( file.name="show1_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show1_hr2.df <- parseTweets("show1_hr2.json")

filterStream( file.name="show1_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show1_hr3.df <- parseTweets("show1_hr3.json")

filterStream( file.name="show1_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show1_hr4.df <- parseTweets("show1_hr4.json")

filterStream( file.name="show1_hr5.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show1_hr5.df <- parseTweets("show1_hr5.json")

show1_tweets <- rbind(show1_hr1.df, show1_hr2.df, show1_hr3.df, show1_hr4.df, show1_hr5.df)

head(show1_tweets$text)

show1_tweets$text = gsub("([.-])|[[:punct:]]", "", show1_tweets$text)
show1_tweets$text = gsub("[.]", " ", show1_tweets$text)
show1_tweets$text = gsub("&amp", "", show1_tweets$text)
show1_tweets$text = gsub("http\\w+", "", show1_tweets$text)
show1_tweets$text = gsub("https\\w+", "", show1_tweets$text)
show1_tweets$text = gsub("\n", " ", show1_tweets$text)
show1_tweets$text = gsub("[ \t]{2,}", "", show1_tweets$text)
show1_tweets$text = gsub("^\\s+|\\s+$", "", show1_tweets$text) 
show1_tweets$text = gsub("@\\w+", "", show1_tweets$text)
show1_tweets$text <- sapply(show1_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show1_tweets$text, n=50)

show1_tweets$description = gsub("([.-])|[[:punct:]]", "", show1_tweets$description)
show1_tweets$description = gsub("[.]", " ", show1_tweets$description)
show1_tweets$description = gsub("&amp", "", show1_tweets$description)
show1_tweets$description = gsub("http\\w+", "", show1_tweets$description)
show1_tweets$description = gsub("https\\w+", "", show1_tweets$description)
show1_tweets$description = gsub("\n", " ", show1_tweets$description)
show1_tweets$description = gsub("[ \t]{2,}", "", show1_tweets$description)
show1_tweets$description = gsub("^\\s+|\\s+$", "", show1_tweets$description) 
show1_tweets$description = gsub("@\\w+", "", show1_tweets$description)
show1_tweets$description <- sapply(show1_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show1_tweets$description, n=500)

head(show1_tweets$created_at)

show1_tweets$created_at <- as.POSIXct(show1_tweets$created_at, format = "%a %b %d %H:%M:%S +0000")

head(show1_tweets)

show1_tweets_subset <- show1_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]

write.csv(show1_tweets_subset, file= "show1_tweets2.csv", row.names = FALSE)

filterStream (file.name ="test.json", track = "thebachelor", timeout=30, oauth = my_oauth)

filterStream( file.name="show2_hr1.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr1.df <- parseTweets("show2_hr1.json")


filterStream( file.name="show2_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr2.df <- parseTweets("show2_hr2.json")


filterStream( file.name="show2_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr3.df <- parseTweets("show2_hr3.json")


filterStream( file.name="show2_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr4.df <- parseTweets("show2_hr4.json")


filterStream( file.name="show2_hr5.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr5.df <- parseTweets("show2_hr5.json")


filterStream( file.name="show2_hr6.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show2_hr6.df <- parseTweets("show2_hr6.json")

show2_tweets <- rbind(show2_hr1.df, show2_hr2.df, show2_hr3.df, show2_hr4.df, show2_hr5.df, show2_hr6.df)

show2_tweets$text = gsub("([.-])|[[:punct:]]", "", show2_tweets$text)
show2_tweets$text = gsub("[.]", " ", show2_tweets$text)
show2_tweets$text = gsub("&amp", "", show2_tweets$text)
show2_tweets$text = gsub("http\\w+", "", show2_tweets$text)
show2_tweets$text = gsub("https\\w+", "", show2_tweets$text)
show2_tweets$text = gsub("\n", " ", show2_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show2_tweets$text = gsub("^\\s+|\\s+$", "", show2_tweets$text) 
show2_tweets$text = gsub("@\\w+", "", show2_tweets$text)
show2_tweets$text <- sapply(show2_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show2_tweets$text, n=50)
head(show2_tweets$location, n=50)

show2_tweets$description = gsub("([.-])|[[:punct:]]", "", show2_tweets$description)
show2_tweets$description = gsub("[.]", " ", show2_tweets$description)
show2_tweets$description = gsub("&amp", "", show2_tweets$description)
show2_tweets$description = gsub("http\\w+", "", show2_tweets$description)
show2_tweets$description = gsub("https\\w+", "", show2_tweets$description)
show2_tweets$description = gsub("\n", " ", show2_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show2_tweets$description = gsub("^\\s+|\\s+$", "", show2_tweets$description) 
show2_tweets$description = gsub("@\\w+", "", show2_tweets$description)
show2_tweets$description <- sapply(show2_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show2_tweets$location <- sapply(show2_tweets$location,function(row) iconv(row, "latin1", "ASCII", sub=""))

head(show2_tweets$description, n=50)

show2_tweets$created_at <- as.POSIXct(show2_tweets$created_at, format = "%a %b %d %H:%M:%S +0000")

head(show2_tweets$created_at, n=50)

show2_tweets_subset <- show2_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]

write.csv(show2_tweets_subset, file= "show2_tweets.csv", row.names = FALSE)

filterStream( file.name="show3_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show3_hr1.df <- parseTweets("show3_hr1.json")

filterStream( file.name="show3_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show3_hr2.df <- parseTweets("show3_hr2.json")

filterStream( file.name="show3_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show3_hr3.df <- parseTweets("show3_hr3.json")

filterStream( file.name="show3_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show3_hr4.df <- parseTweets("show3_hr4.json")

filterStream( file.name="show3_hr5.json",
              track="thebachelor", timeout=3900, oauth=my_oauth )

show3_hr5.df <- parseTweets("show3_hr5.json")

show3_tweets <- rbind(show3_hr1.df, show3_hr2.df, show3_hr3.df, show3_hr4.df, show3_hr5.df)

show3_tweets$text = gsub("([.-])|[[:punct:]]", "", show3_tweets$text)
show3_tweets$text = gsub("[.]", " ", show3_tweets$text)
show3_tweets$text = gsub("&amp", "", show3_tweets$text)
show3_tweets$text = gsub("http\\w+", "", show3_tweets$text)
show3_tweets$text = gsub("https\\w+", "", show3_tweets$text)
show3_tweets$text = gsub("\n", " ", show3_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show3_tweets$text = gsub("^\\s+|\\s+$", "", show3_tweets$text) 
show3_tweets$text = gsub("@\\w+", "", show3_tweets$text)
show3_tweets$text <- sapply(show3_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show2_tweets$text, n=50)
head(show2_tweets$location, n=50)

show3_tweets$description = gsub("([.-])|[[:punct:]]", "", show3_tweets$description)
show3_tweets$description = gsub("[.]", " ", show3_tweets$description)
show3_tweets$description = gsub("&amp", "", show3_tweets$description)
show3_tweets$description = gsub("http\\w+", "", show3_tweets$description)
show3_tweets$description = gsub("https\\w+", "", show3_tweets$description)
show3_tweets$description = gsub("\n", " ", show3_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show3_tweets$description = gsub("^\\s+|\\s+$", "", show3_tweets$description) 
show3_tweets$description = gsub("@\\w+", "", show3_tweets$description)
show3_tweets$description <- sapply(show3_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show3_tweets$location <- sapply(show3_tweets$location,function(row) iconv(row, "latin1", "ASCII", sub=""))

head(show2_tweets$description, n=50)

show3_tweets$created_at <- as.POSIXct(show3_tweets$created_at, format = "%a %b %d %H:%M:%S +0000")

head(show3_tweets, n=50)

show3_tweets_subset <- show3_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]

write.csv(show3_tweets_subset, file= "show3_tweets.csv", row.names = FALSE)


filterStream( file.name="show5_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show5_hr1.df <- parseTweets("show5_hr1.json")

filterStream( file.name="show5_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show5_hr2.df <- parseTweets("show5_hr2.json")

filterStream( file.name="show5_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show5_hr3.df <- parseTweets("show5_hr3.json")

filterStream( file.name="show5_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show5_hr4.df <- parseTweets("show5_hr4.json")

filterStream( file.name="show5_hr5.json",
              track="thebachelor", timeout=3900, oauth=my_oauth )

filterStream( file.name="show5_hr7.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )


show5_hr5.df <- parseTweets("show5_hr5.json")
show5_hr7.df <- parseTweets("show5_hr7.json")

show5_tweets <- rbind(show5_hr1.df, show5_hr2.df, show5_hr3.df, show5_hr4.df, show5_hr5.df, show5_hr7.df)

show5_tweets$text = gsub("([.-])|[[:punct:]]", "", show5_tweets$text)
show5_tweets$text = gsub("[.]", " ", show5_tweets$text)
show5_tweets$text = gsub("&amp", "", show5_tweets$text)
show5_tweets$text = gsub("http\\w+", "", show5_tweets$text)
show5_tweets$text = gsub("https\\w+", "", show5_tweets$text)
show5_tweets$text = gsub("\n", " ", show5_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show5_tweets$text = gsub("^\\s+|\\s+$", "", show5_tweets$text) 
show5_tweets$text = gsub("@\\w+", "", show5_tweets$text)
show5_tweets$text <- sapply(show5_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show5_tweets$text, n=50)
head(show2_tweets$description, n=50)

show5_tweets$description = gsub("([.-])|[[:punct:]]", "", show5_tweets$description)
show5_tweets$description = gsub("[.]", " ", show5_tweets$description)
show5_tweets$description = gsub("&amp", "", show5_tweets$description)
show5_tweets$description = gsub("http\\w+", "", show5_tweets$description)
show5_tweets$description = gsub("https\\w+", "", show5_tweets$description)
show5_tweets$description = gsub("\n", " ", show5_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show5_tweets$description = gsub("^\\s+|\\s+$", "", show5_tweets$description) 
show5_tweets$description = gsub("@\\w+", "", show5_tweets$description)
show5_tweets$description <- sapply(show5_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show5_tweets_subset <- show5_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]


write.csv(show5_tweets_subset, file= "show5_tweets.csv", row.names = FALSE)


show4_hr1.df <- parseTweets("show4_hr01.json")
show4_hr2.df <- parseTweets("show4_hr02.json")

show4_hr3.df <- parseTweets("show4_hr3.json")

show4_hr4.df <- parseTweets("show4_hr4.json")

show4_tweets <- rbind(show4_hr1.df, show4_hr2.df, show4_hr3.df, show4_hr4.df)

show4_tweets$text = gsub("([.-])|[[:punct:]]", "", show4_tweets$text)
show4_tweets$text = gsub("[.]", " ", show4_tweets$text)
show4_tweets$text = gsub("&amp", "", show4_tweets$text)
show4_tweets$text = gsub("http\\w+", "", show4_tweets$text)
show4_tweets$text = gsub("https\\w+", "", show4_tweets$text)
show4_tweets$text = gsub("\n", " ", show4_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show4_tweets$text = gsub("^\\s+|\\s+$", "", show4_tweets$text) 
show4_tweets$text = gsub("@\\w+", "", show4_tweets$text)
show4_tweets$text <- sapply(show4_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show4_tweets$text, n=40)
head(show2_tweets$description, n=40)

show4_tweets$description = gsub("([.-])|[[:punct:]]", "", show4_tweets$description)
show4_tweets$description = gsub("[.]", " ", show4_tweets$description)
show4_tweets$description = gsub("&amp", "", show4_tweets$description)
show4_tweets$description = gsub("http\\w+", "", show4_tweets$description)
show4_tweets$description = gsub("https\\w+", "", show4_tweets$description)
show4_tweets$description = gsub("\n", " ", show4_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show4_tweets$description = gsub("^\\s+|\\s+$", "", show4_tweets$description) 
show4_tweets$description = gsub("@\\w+", "", show4_tweets$description)
show4_tweets$description <- sapply(show4_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show4_tweets_subset <- show4_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]


write.csv(show4_tweets_subset, file= "show4_tweets.csv", row.names = FALSE)

head(show5_hr1.df$created_at)
head(show5_hr2.df$created_at)


filterStream( file.name="show6_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show6_hr1.df <- parseTweets("show6_hr1.json")

filterStream( file.name="show6_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show6_hr2.df <- parseTweets("show6_hr2.json")

filterStream( file.name="show6_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show6_hr3.df <- parseTweets("show6_hr3.json")

filterStream( file.name="show6_hr4.json",
              track="thebachelor", timeout=7200, oauth=my_oauth )

show6_hr4.df <- parseTweets("show6_hr4.json")

filterStream( file.name="show6_hr5.json",
              track="thebachelor", timeout=3900, oauth=my_oauth )





filterStream( file.name="show7_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show7_hr1.df <- parseTweets("show7_hr1.json")

filterStream( file.name="show7_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr2.df <- parseTweets("show7_hr2.json")

filterStream( file.name="show7_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr3.df <- parseTweets("show7_hr3.json")

filterStream( file.name="show7_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr4.df <- parseTweets("show6_hr1.json")

filterStream( file.name="show7_hr5.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr5.df <- parseTweets("show7_hr5.json")


filterStream( file.name="show7_hr6.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr6.df <- parseTweets("show7_hr6.json")

3188185
show8_hr1.df <- parseTweets("show8_hr1.json")

filterStream( file.name="show8_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show8_hr2.df <- parseTweets("show8_hr2.json")

filterStream( file.name="show8_hr3.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show8_hr3.df <- parseTweets("show8_hr3.json")

filterStream( file.name="show8_hr4.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show8_hr4.df <- parseTweets("show8_hr4.json")

filterStream( file.name="show8_hr5.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show8_hr5.df <- parseTweets("show8_hr5.json")


show6_tweets <- rbind(show6_hr1.df, show6_hr2.df, show6_hr3.df, show6_hr4.df)

show6_tweets$text = gsub("([.-])|[[:punct:]]", "", show6_tweets$text)
show6_tweets$text = gsub("[.]", " ", show6_tweets$text)
show6_tweets$text = gsub("&amp", "", show6_tweets$text)
show6_tweets$text = gsub("http\\w+", "", show6_tweets$text)
show6_tweets$text = gsub("https\\w+", "", show6_tweets$text)
show6_tweets$text = gsub("\n", " ", show6_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show6_tweets$text = gsub("^\\s+|\\s+$", "", show6_tweets$text) 
show6_tweets$text = gsub("@\\w+", "", show6_tweets$text)
show6_tweets$text <- sapply(show6_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))



show6_tweets$description = gsub("([.-])|[[:punct:]]", "", show6_tweets$description)
show6_tweets$description = gsub("[.]", " ", show6_tweets$description)
show6_tweets$description = gsub("&amp", "", show6_tweets$description)
show6_tweets$description = gsub("http\\w+", "", show6_tweets$description)
show6_tweets$description = gsub("https\\w+", "", show6_tweets$description)
show6_tweets$description = gsub("\n", " ", show6_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show6_tweets$description = gsub("^\\s+|\\s+$", "", show6_tweets$description) 
show6_tweets$description = gsub("@\\w+", "", show6_tweets$description)
show6_tweets$description <- sapply(show6_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))


head(show6_tweets$text, n=40)
head(show6_tweets$description, n=40)

show7_tweets <- rbind(show7_hr1.df, show7_hr2.df, show7_hr3.df, show7_hr4.df, show7_hr5.df, show7_hr6.df)


show7_tweets$text = gsub("([.-])|[[:punct:]]", "", show7_tweets$text)
show7_tweets$text = gsub("[.]", " ", show7_tweets$text)
show7_tweets$text = gsub("&amp", "", show7_tweets$text)
show7_tweets$text = gsub("http\\w+", "", show7_tweets$text)
show7_tweets$text = gsub("https\\w+", "", show7_tweets$text)
show7_tweets$text = gsub("\n", " ", show7_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show7_tweets$text = gsub("^\\s+|\\s+$", "", show7_tweets$text) 
show7_tweets$text = gsub("@\\w+", "", show7_tweets$text)
show7_tweets$text <- sapply(show7_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))



show7_tweets$description = gsub("([.-])|[[:punct:]]", "", show7_tweets$description)
show7_tweets$description = gsub("[.]", " ", show7_tweets$description)
show7_tweets$description = gsub("&amp", "", show7_tweets$description)
show7_tweets$description = gsub("http\\w+", "", show7_tweets$description)
show7_tweets$description = gsub("https\\w+", "", show7_tweets$description)
show7_tweets$description = gsub("\n", " ", show7_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show7_tweets$description = gsub("^\\s+|\\s+$", "", show7_tweets$description) 
show7_tweets$description = gsub("@\\w+", "", show7_tweets$description)
show7_tweets$description <- sapply(show7_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

head(show7_tweets$text, n=40)
head(show7_tweets$description, n=40)

show8_tweets <- rbind(show8_hr1.df, show8_hr2.df, show8_hr3.df, show8_hr4.df, show8_hr5.df)


show8_tweets$text = gsub("([.-])|[[:punct:]]", "", show8_tweets$text)
show8_tweets$text = gsub("[.]", " ", show8_tweets$text)
show8_tweets$text = gsub("&amp", "", show8_tweets$text)
show8_tweets$text = gsub("http\\w+", "", show8_tweets$text)
show8_tweets$text = gsub("https\\w+", "", show8_tweets$text)
show8_tweets$text = gsub("\n", " ", show8_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show8_tweets$text = gsub("^\\s+|\\s+$", "", show8_tweets$text) 
show8_tweets$text = gsub("@\\w+", "", show8_tweets$text)
show8_tweets$text <- sapply(show8_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))



show8_tweets$description = gsub("([.-])|[[:punct:]]", "", show8_tweets$description)
show8_tweets$description = gsub("[.]", " ", show8_tweets$description)
show8_tweets$description = gsub("&amp", "", show8_tweets$description)
show8_tweets$description = gsub("http\\w+", "", show8_tweets$description)
show8_tweets$description = gsub("https\\w+", "", show8_tweets$description)
show8_tweets$description = gsub("\n", " ", show8_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show8_tweets$description = gsub("^\\s+|\\s+$", "", show8_tweets$description) 
show8_tweets$description = gsub("@\\w+", "", show8_tweets$description)
show8_tweets$description <- sapply(show8_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

head(show8_tweets$text, n=40)
head(show8_tweets$description, n=40)

head(show8_tweets$created_at)


show6_tweets_subset <- show6_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]
show7_tweets_subset <- show7_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]
show8_tweets_subset <- show8_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]



write.csv(show6_tweets_subset, file= "show6_tweets.csv", row.names = FALSE)
write.csv(show7_tweets_subset, file= "show7_tweets.csv", row.names = FALSE)
write.csv(show8_tweets_subset, file= "show8_tweets.csv", row.names = FALSE)



filterStream( file.name="show8_hr2.json",
              track="thebachelor", timeout=5800, oauth=my_oauth )

show7_hr2.df <- parseTweets("show7_hr2.json")

filterStream( file.name="show8_hr2.json",
              track="thebachelor", timeout=3600, oauth=my_oauth )

show7_hr3.df <- parseTweets("show7_hr3.json")


head(show9_hr1.df)

filterStream( file.name="show9_hr1.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

filterStream( file.name="show9_hr2.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

filterStream( file.name="show9_hr4.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

filterStream( file.name="show9_hr5.json",
              track="thebachelor", timeout=4500, oauth=my_oauth )

show9_hr1.df <- parseTweets("show9_hr1.json")
show9_hr2.df <- parseTweets("show9_hr2.json")
show9_hr3.df <- parseTweets("show9_hr3.json")
show9_hr4.df <- parseTweets("show9_hr4.json")
show9_hr5.df <- parseTweets("show9_hr5.json")

show9_tweets <- rbind(show9_hr1.df, show9_hr2.df, show9_hr3.df, show9_hr4.df, show9_hr5.df)


show9_tweets$text = gsub("([.-])|[[:punct:]]", "", show9_tweets$text)
show9_tweets$text = gsub("[.]", " ", show9_tweets$text)
show9_tweets$text = gsub("&amp", "", show9_tweets$text)
show9_tweets$text = gsub("http\\w+", "", show9_tweets$text)
show9_tweets$text = gsub("https\\w+", "", show9_tweets$text)
show9_tweets$text = gsub("\n", " ", show9_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show9_tweets$text = gsub("^\\s+|\\s+$", "", show9_tweets$text) 
show9_tweets$text = gsub("@\\w+", "", show9_tweets$text)
show9_tweets$text <- sapply(show9_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))



show9_tweets$description = gsub("([.-])|[[:punct:]]", "", show9_tweets$description)
show9_tweets$description = gsub("[.]", " ", show9_tweets$description)
show9_tweets$description = gsub("&amp", "", show9_tweets$description)
show9_tweets$description = gsub("http\\w+", "", show9_tweets$description)
show9_tweets$description = gsub("https\\w+", "", show9_tweets$description)
show9_tweets$description = gsub("\n", " ", show9_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show9_tweets$description = gsub("^\\s+|\\s+$", "", show9_tweets$description) 
show9_tweets$description = gsub("@\\w+", "", show9_tweets$description)
show9_tweets$description <- sapply(show9_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show9_tweets_subset <- show9_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]
write.csv(show9_tweets_subset, file= "show9_tweets.csv", row.names = FALSE)


show10_hr1.df <- parseTweets("show10_hr1.json")
show10_hr2.df <- parseTweets("show10_hr2.json")
show10_hr3.df <- parseTweets("show10_hr3.json")
show10_hr4.df <- parseTweets("show10_hr4.json")
show10_hr5.df <- parseTweets("show10_hr5.json")


show10_tweets <- rbind(show10_hr1.df, show10_hr2.df, show10_hr3.df, show10_hr4.df, show10_hr5.df)


show10_tweets$text = gsub("([.-])|[[:punct:]]", "", show10_tweets$text)
show10_tweets$text = gsub("[.]", " ", show10_tweets$text)
show10_tweets$text = gsub("&amp", "", show10_tweets$text)
show10_tweets$text = gsub("http\\w+", "", show10_tweets$text)
show10_tweets$text = gsub("https\\w+", "", show10_tweets$text)
show10_tweets$text = gsub("\n", " ", show10_tweets$text)
#show2_tweets$text = gsub("[ \t]{2,}", "", show2_tweets$text)
show10_tweets$text = gsub("^\\s+|\\s+$", "", show10_tweets$text) 
show10_tweets$text = gsub("@\\w+", "", show10_tweets$text)
show10_tweets$text <- sapply(show10_tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))



show10_tweets$description = gsub("([.-])|[[:punct:]]", "", show10_tweets$description)
show10_tweets$description = gsub("[.]", " ", show10_tweets$description)
show10_tweets$description = gsub("&amp", "", show10_tweets$description)
show10_tweets$description = gsub("http\\w+", "", show10_tweets$description)
show10_tweets$description = gsub("https\\w+", "", show10_tweets$description)
show10_tweets$description = gsub("\n", " ", show10_tweets$description)
##show2_tweets$description = gsub("[ \t]{2,}", "", show2_tweets$description)
show10_tweets$description = gsub("^\\s+|\\s+$", "", show10_tweets$description) 
show10_tweets$description = gsub("@\\w+", "", show10_tweets$description)
show10_tweets$description <- sapply(show10_tweets$description,function(row) iconv(row, "latin1", "ASCII", sub=""))

show10_tweets_subset <- show10_tweets[,c("text","id_str","verified","location","user_id_str","description","geo_enabled","statuses_count","followers_count","name","time_zone","screen_name","lat","lon","created_at")]
write.csv(show10_tweets_subset, file= "show10_tweets.csv", row.names = FALSE)
head(show8_hr1.df$created_at, n=1000)
