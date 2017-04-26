$(function () {
    //筛选
    $("#select1 dd").click(function () {
        $(this).addClass("selected").siblings().removeClass("selected");
        var copyThisA = $(this).clone();
        //console.log(copyThisA);
        if ($("#selectA").length > 0) {
            $("#selectA a").html($(this).text());
        } else {
            $(".select-result dl").append(copyThisA.attr("id", "selectA"));
        }
    });
    $("#select2 dd").click(function () {
        $(this).addClass("selected").siblings().removeClass("selected");
        var copyThisC = $(this).clone();
        if ($("#selectC").length > 0) {
            $("#selectC a").html($(this).text());
        } else {
            $(".select-result dl").append(copyThisC.attr("id", "selectC"));
        }
    });
    $(document).on("click", "#selectA", function () {
        $(this).remove();
        $("#select1 dd").removeClass("selected");
    });
    $(".select-result dl").delegate("dd", "click", function () {
        $(this).fadeOut();
    });
    $(document).on("click", "#selectC", function () {
        $(this).remove();
        $("#select2 dd").removeClass("selected");
    });
});