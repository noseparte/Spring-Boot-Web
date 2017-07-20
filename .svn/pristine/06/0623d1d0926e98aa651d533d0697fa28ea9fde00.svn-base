/**
 * Created by mac on 16/6/30.
 */

$(window).unload(function () {
    WebClient.UnLoad();
});
if (window.attachEvent) {
    window.attachEvent(
        "onbeforeunload",
        function() {
            WebClient.UnLoad();
        }
    );
}
else {
    window.addEventListener (
        "beforeunload",
        function() {
            WebClient.UnLoad();
        },
        false
    );
}