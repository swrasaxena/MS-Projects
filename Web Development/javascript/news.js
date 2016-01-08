$('#myTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
});

$(document).ready(function () {
    getNews();
});

function getNews() {
    $.ajax({
        url: "http://api.espn.com/v1/sports/football/nfl/news/headlines",
        data: { apikey: "ka8rz4ty29pv437chne9xyqf" },
        dataType: "jsonp",
        success: function (response) {
            var display = $("#accordion");
            var j = 0;
            var headlines = response.headlines;
            for (var i in headlines)
            {
                var news = headlines[i];
                var headline = news.headline;
                var description = news.description;
                var images = news.images;
                var link = news.links.web.href;
                if (typeof (images[0]) === "undefined")
                {
                    var imageUrl = "http://www.51allout.co.uk/wp-content/uploads/2012/02/Image-not-found.gif";
                }
                else
                {
                    var imageUrl = images[0].url;
                }
                var h3 = $("<h3>");
                var div = $("<div>");
                h3.append(headline);
                var li = $("<li>");
                li.append("Description: " + description);
                div.append(li);
                var a = $("<a>");
                li = $("<li>");
                a.attr("class", "link");
                a.attr("href", link);
                a.attr("target", "_blank");
                a.append("Read More >>");
                li.append(a);
                div.append(li);
                li = $("<li>")
                var img = $("<img>");
                img.attr("src", imageUrl);
                img.height(200);
                img.width(300);
                img.attr("class", "img-responsive");
                li.append(img);
                div.append(li);
                display.append(h3);
                display.append(div);
            }
            $("#accordion").accordion();
        },
        error: function (response) {
            var outerDiv = $(".tab-content #general #accordion");
            outerDiv.append("ESPN API is down, please try again later");
        }
    });
}
