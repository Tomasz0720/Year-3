// 10_callback.js - CSS styling
// CSCI3230U
// See: 8_callback_style.html

$("p").on("dblclick.colour", function () {
    $(this).css({ color: "red" });
});

$("p").on("click.size", function () {
    $(this).css({ fontSize: 18 });
});

$("p").on("click.background", function () {
    $(this).css({ background: "yellow" });
});

$("#myList").click(function () {
    $("p").off("dblclick.colour");
    $("p").off("click.background");
});
  // Disable dblclick event listener function
  //$("p").off("dblclick.colour");
