$(document).ready(function () {
    displayVideos();
});

function displayVideos() {
    $.ajax({
        url: "http://api.espn.com/v1/now/",
        data: {  leagues: "nfl", content: "video", apikey: "ka8rz4ty29pv437chne9xyqf" },
        dataType: "jsonp",
        success: function (response) {
            //console.log(response);
            var display = $("#accordion");
            for (i in response.feed)
            {
                var feed = response.feed[i];
                console.log(feed);
                var headline = feed.headline;
                var description = feed.description;
                var externallink = feed.links.web.href;
                var image = feed.images[0].url;
                var videolink = feed.video[0].links.source.mezzanine.href;
                var h3 = $("<h3>");
                var div = $("<div>");
                var br = $("<br />");
                h3.append(headline);
                div.append("Description: " + description);
                div.append(br);
                div.append(br);
                var img = $("<img>");
                img.attr("src", image);
                img.height(150);
                img.width(300);
                div.append(img);
                div.append(br);
                div.append(br);
                var a = $("<a>");
                a.attr("href", externallink);
                a.attr("target", "_blank");
                a.append("Read More >>");
                div.append(a);
                var video = $("<video>");
                video.attr("width", "580");
                video.attr("height", "320");
                video.attr("preload", "auto");
                video.attr("controls", "controls");
                var source = $("<source>");
                source.attr("src", videolink);
                source.attr("type", 'video/mp4; codecs="avc1.42E01E, mp4a.40.2"');
                video.append(source);
                div.append(br);
                div.append(br);
                div.append(video);

                display.append(h3);
                display.append(div);
            }
            $("#accordion").accordion();
        }
    });
}