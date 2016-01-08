$(document).ready(function () {
    $('button').click(getPlayer);
});

function getPlayer() {
    var lastname = $("#txtPlayer").val();
    $.ajax({
        url: "http://api.espn.com/v1/sports/football/nfl/athletes/",
        data: { apikey: "ka8rz4ty29pv437chne9xyqf" },
        dataType: "jsonp",
        success: function (response) {

            console.log(response);
            var flag = false;
            var sport = response.sports[0];
            var league = sport.leagues[0];
            var athletes = league.athletes
            var display = $(".display-result");
            var ul = $("<ul>");
            ul.empty();
            display.empty();
            var remLastName = lastname.slice(1);
            for (var i in athletes)
            {
                var athlete = athletes[i];
                if (lastname.charAt(0).toUpperCase() + remLastName.toLowerCase() == athlete.lastName)
                {
                    var id = athlete.id;
                    var lname = athlete.lastName;
                    var fname = athlete.firstName;
                    var fullname = athlete.fullName;
                    var displayname = athlete.displayName;
                    var plink = athlete.links.web.athletes.href;
                    var ul = $("<ul>");
                    ul.attr("class", "results");
                    var li = $("<li>");
                    li.append("Player ID: " + id);
                    ul.append(li);
                    li = $("<li>");
                    li.append("First Name: " + fname);
                    ul.append(li);
                    li = $("<li>");
                    li.append("Last Name: " + lname);
                    ul.append(li);
                    li = $("<li>");
                    li.append("Full Name: " + fullname);
                    ul.append(li);
                    li = $("<li>");
                    li.append("Display Name: " + displayname);
                    ul.append(li);
                    li = $("<li>");
                    var a = $("<a>");
                    a.attr("href", plink);
                    a.attr("target", "_blank");
                    a.append("Player Profile Link - Click to navigate");
                    li.append(a);
                    ul.append(li);
                    display.append(ul);
                    flag = true;
                }
            }
            if (flag == false)
            {
                ul.attr("class", "error");
                ul.append("No results found, please try a different last name.");
                display.append(ul);
            }
            $("#txtPlayer").focus(function () {
                $(this).val("");
            });
        },
        error: function () {
            var display = $(".display-result");
            display.empty();
            display.append("ESPN API is down, please try again later!");
            $("#txtPlayer").empty();
        }
    });
}