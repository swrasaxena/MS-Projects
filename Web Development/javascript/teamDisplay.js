$(document).ready(function () {
    getTeam();
});


function getTeam() {
    $.ajax({
            url: "http://api.espn.com/v1/sports/football/nfl/teams/",
            data: { apikey: "ka8rz4ty29pv437chne9xyqf" },
            dataType: "jsonp",
            success: function (response)
            {
                var sport = response.sports[0];
                var league = sport.leagues[0];
                var leaguename = $(".leaguename");
                leaguename.append(league.name);
                var teams = league.teams;
                var display = $(".data");
                for (var i in teams)
                {
                    var team = teams[i];
                    var link = team.links.web.teams.href;
                    var name = team.name;
                    var location = team.location;
                    var teamName = location + " " + name;
                    var color = team.color;
                    var id = team.id;
                    var tr = $("<tr>");
                    var td = $("<td>");
                    var a = $("<a/>");
                    tr.attr("class", "record");
                    a.attr("class", "link");
                    a.attr("href", link);
                    a.attr("target", "_blank");
                    a.append("Click here to view team profile");
                    td.append(id);
                    tr.append(td);
                    td = $("<td>");
                    td.append(name);
                    tr.append(td);
                    td = $("<td>");
                    td.append(location);
                    tr.append(td);
                    td = $("<td>");
                    td.append(a);
                    tr.append(td);
                    tr.attr("bgcolor", color);
                    display.append(tr);
                }
            },
            error: function()
            {
                var display = $(".data");
                display.append("ESPN API is currently down. Please try later to view NFL teams!");
            }
        });
}