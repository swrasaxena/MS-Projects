$(document).ready(function () {
    displayVideos();
});

function displayVideos() {
    $.ajax({
        url: "http://api.espn.com/v1/now/",
        data: { leagues: "nfl", content: "video", apikey: "ka8rz4ty29pv437chne9xyqf" },
        dataType: "jsonp",
        success: function (response) {
            
            var j = 0;
            var panelBody = $(".panel-body");
            var videoContainer = $(".video-modals");
            videoContainer.empty();
            for (i in response.feed)
            {
                var feed = response.feed[i];
                
                var headline = feed.headline;
                var description = feed.description;
                var externallink = feed.links.web.href;
                var image = feed.images[0].url;
                var videolink = feed.video[0].links.source.mezzanine.href;
                var h4 = $("<h4>");
                var div = $("<div>");
                h4.append(headline);
                div.append(description);
                var a = $("<a>");
                a.attr("href", "#myModal" + j);
                a.attr("data-toggle", "modal");
                a.append("Watch video here");
                div.append(a);
                panelBody.append(h4);
                panelBody.append(div);

                var outermostDiv = $("<div>");
                outermostDiv.attr("class", "modal fade");
                outermostDiv.attr("id", "myModal" + j);
                var div1 = $("<div>");
                div1.attr("class", "modal-dialog");
                var div2 = $("<div>");
                div2.attr("class", "modal-content");
                var div3 = $("<div>");
                div3.attr("class", "modal-header");
                var button = $("<button>");
                button.attr("type", "button");
                button.attr("class", "close");
                button.attr("aria-hidden", "true");
                button.attr("data-dismiss", "modal");
                button.append("&times;");
                h4 = $("<h4>");
                h4.attr("class", "modal-title");
                h4.append("Related Video");
                div3.append(button);
                div3.append(h4);
                div2.append(div3);
                var div4 = $("<div>");
                div4.attr("class", "modal-body");
                var video = $("<video>");
                video.attr("id", "myVideo");
                video.attr("width", "580");
                video.attr("height", "320");
                video.attr("preload", "auto");
                video.attr("controls", "controls");
                var source = $("<source>");
                if (videolink == null || videolink == "")
                {
                    div4.append("Sorry, no video available at this time.");
                }
                else
                {
                    source.attr("src", videolink);
                    source.attr("type", 'video/mp4; codecs="avc1.42E01E, mp4a.40.2"');
                    video.append(source);
                    div4.append(video);
                }
                
                div2.append(div4);
                div1.append(div2);
                outermostDiv.append(div1);
                videoContainer.append(outermostDiv);
                j = j + 1;
            }
            
        },
        error: function()
        {
            var panelBody = $(".panel-body");
            panelBody.append("ESPN API is down, please try again later.");
        }
    });
}