function initialize() {
    var url = "https://news.google.com/news/feeds?q=Seattle Seahawks&output=rss";
    var feed = new google.feeds.Feed(url);
    feed.setNumEntries(10);
    feed.load(function (result) {
        if (!result.error) {
            var container = $("#feed");
            console.log(result.feed.entries);
            console.log(result.feed.entries.length);
            for (var i = 0; i < result.feed.entries.length; i++) {
                var entry = result.feed.entries[i];
                container.append('<a href="' + entry.link + '" target="_blank">' + entry.title + ' </a><br /><br />');
            }
        }
    });
}
