// 8_jquery_dom_update.js - Element creation
// CSCI3230U

let i, newItem;

//$("#myList").find("li").remove();

for (i = 1; i < 5; i += 1) {
    newItem = $("<li> Item " + i + "</li>");
    if (i % 2) {
        newItem.addClass("odd");
    } else {
        newItem.addClass("even");
    }
    $("#myList").append(newItem);
}

$(".final").append($("<p>Lets add some red text after our last paragraph</p>").addClass("red"));

$(".red").css({
    color: "red",
    fontWeight: "bold", backgroundColor: "lightblue"
});

$("p").click(function () {
    $(this).css({ color: "green" });
});
