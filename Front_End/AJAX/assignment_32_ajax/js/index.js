var user_id = 32; // 自己的座號

function init() {
    $.ajax({
        url: "https://notes.webmix.cc/ajax/teach/api/list.php",
        type: "GET",
        data: {"user_id": user_id},
        dataType: "json",
        beforeSend: function(){
            $("ul.task_list").html('<li style="text-align: center;"><i class="fas fa-spinner fa-spin fa-3x"></i></li>');
        },
        success: function(data){
            // console.log(data);
            $.each(data, function(index, item){
                let task_html =
                `<li data-id=${item.item_id} data-star=${item.star} data-sort=${item.sort}>
                    <div class="item_flex">
                        <div class="left_block">
                            <div class="btn_flex">
                            <button type="button" class="btn_up">往上</button>
                            <button type="button" class="btn_down">往下</button>
                            </div>
                        </div>
                    <div class="middle_block">
                        <div class="star_block">
                        <span class="star ${item.star > 0 ? " -on": ""}" data-star="1"><i class="fas fa-star"></i></span>
                        <span class="star ${item.star > 1 ? " -on": ""}" data-star="2"><i class="fas fa-star"></i></span>
                        <span class="star ${item.star > 2 ? " -on": ""}" data-star="3"><i class="fas fa-star"></i></span>
                        <span class="star ${item.star > 3 ? " -on": ""}" data-star="4"><i class="fas fa-star"></i></span>
                        <span class="star ${item.star > 4 ? " -on": ""}" data-star="5"><i class="fas fa-star"></i></span>
                        </div>
                        <p class="para">${item.name}</p>
                        <input type="text" class="task_name_update -none" placeholder="更新待辦事項…" value=${item.name}>
                    </div>
                    <div class="right_block">
                        <div class="btn_flex">
                            <button type="button" class="btn_update">更新</button>
                            <button type="button" class="btn_delete">移除</button>
                            </div>
                        </div>
                    </div>
                </li>`;
            $("ul.task_list").append(task_html);

            });
        },
        error: function(xhr) {
            console.log(xhr);
        },
        complete: function() {
            $("ul.task_list > li:first-child").remove();
        }
    });
}

function reloadSort() {
    let liArr = $("ul.task_list").children("li");
    let dataArr = new Array(liArr.length);
    $.each(liArr, function(index, item){
        $(item).attr("data-sort", (index + 1));
        dataArr[index] = {
            "item_id": $(item).attr("data-id"),
            "sort": $(item).attr("data-sort")
        };
    });
    $.ajax({
        url: "https://notes.webmix.cc/ajax/teach/api/patch_sort.php",
        type: "PATCH",
        data: {
            "user_id": user_id,
            "data": dataArr
        },
        dataType: "json",
        beforeSend: function() {
            $("article.task_container").append("<div class='temp_loading'><span><i class='fas fa-spinner fa-spin fa-5x'></i></span></div>");
        },
        success: function(data) {
            // console.log(data);
        },
        error: function(xhr) {

        },
        complete: function() {
            $("article.task_container").children("div.temp_loading").remove();
        }
    });
}

$(function(){

    init();

    $("input.task_name").on("focus", function(){
        $(this).closest("div.task_add_block").addClass("-on");
    });

    $("input.task_name").on("blur", function(){
        $(this).closest("div.task_add_block").removeClass("-on");
    });

    $("input.task_name").on("keyup", function(e){
        if(e.which == 13) {
            $("button.task_add").click();
        }
    });

    $("button.task_add").on("click", function(){
        let task_text = $("input.task_name").val().trim();
        if (task_text != 0) {
            if(!$(this).hasClass("-disabled")) {
                $.ajax({
                    url: "https://notes.webmix.cc/ajax/teach/api/add.php",
                    type: "POST",
                    data: {
                        "user_id": user_id,
                        "name": task_text
                    },
                    dataType: "json",
                    beforeSend: function() {
                        $("button.task_add").addClass("-disabled");
                    },
                    success: function(data) {
                        // console.log(data);
                        
                        let task_html = 
                        `<li data-id=${data.item_id} data-star=${data.star} data-sort=${data.sort}>
                            <div class="item_flex">
                                <div class="left_block">
                                    <div class="btn_flex">
                                    <button type="button" class="btn_up">往上</button>
                                    <button type="button" class="btn_down">往下</button>
                                    </div>
                                </div>
                            <div class="middle_block">
                                <div class="star_block">
                                <span class="star" data-star="1"><i class="fas fa-star"></i></span>
                                <span class="star" data-star="2"><i class="fas fa-star"></i></span>
                                <span class="star" data-star="3"><i class="fas fa-star"></i></span>
                                <span class="star" data-star="4"><i class="fas fa-star"></i></span>
                                <span class="star" data-star="5"><i class="fas fa-star"></i></span>
                                </div>
                                <p class="para">${task_text}</p>
                                <input type="text" class="task_name_update -none" placeholder="更新待辦事項…" value=${task_text}>
                            </div>
                            <div class="right_block">
                                <div class="btn_flex">
                                    <button type="button" class="btn_update">更新</button>
                                    <button type="button" class="btn_delete">移除</button>
                                    </div>
                                </div>
                            </div>
                        </li>`;
                        $("ul.task_list").prepend(task_html);
                        // console.log($("input.task_name").val());
                        $("input.task_name").val("");
                        reloadSort();
                    },
                    error: function(xhr) {
                        console.log(xhr);
                    },
                    complete: function() {
                        $("button.task_add").removeClass("-disabled");
                    }
                });
            }
        }
    });


    $("button.btn_empty").on("click", function(){
        
        let r = confirm("確認要清空?");
        if (r) {
            $.ajax({
                url: "https://notes.webmix.cc/ajax/teach/api/delete_all.php",
                type: "DELETE",
                data: {"user_id": user_id},
                dataType: "json",
                beforeSend: function() {

                },
                success: function(data) {
                    // console.log(data);
                    if(data.msg == "delete all success") {
                        $("ul.task_list").children("li").animate({"opacity": 0}, 1000, "swing", function(){
                            $(this).remove();
                        });
                    }
                },
                error: function(xhr) {
                    console.log(xhr);
                }
            });
        }
        
    });

    $("ul.task_list").on("click", "button.btn_delete", function(){
        let r = confirm("確認要移除?");
        let target = $(this).closest("li");

        if (r) {
            $.ajax({
                url: "https://notes.webmix.cc/ajax/teach/api/delete_item.php",
                type: "DELETE",
                data: {
                    "user_id": user_id,
                    "item_id": target.attr("data-id")
                },
                dataType: "json",
                beforeSend: function() {

                },
                success: function(data) {
                    // console.log(data.msg);
                    if (data.msg == "delete success") {
                        target.animate({"opacity": 0}, 1000, "swing", function(){
                            $(this).remove();
                            reloadSort();
                        });
                    }
                },
                error: function(xhr) {
                    console.log(xhr);
                }
            });
        }

        
    });

    // 更新待辦事項
    $("ul.task_list").on("click", "button.btn_update", function(){
        // console.log($(this));
        if($(this).attr("data-updating") == true){
            return;
        };

        let task_name_update = $(this).closest("li").find("input.task_name_update");
        
        let that = this;

        if($(this).attr("data-edit") == undefined){
            $(this).attr("data-edit", true);
            task_name_update.siblings("p.para").toggleClass("-none");
            task_name_update.toggleClass("-none");
        }else{
            task_name_update.val(task_name_update.val().trim());
            if (task_name_update.val() == "") {
                alert("請輸入待辦事項");
            } else {
                

                
                $.ajax({
                    url: "https://notes.webmix.cc/ajax/teach/api/update_item.php",
                    type: "PUT",
                    data: {
                        "user_id": user_id,
                        "item_id": $(that).closest("li").attr("data-id"),
                        "name": task_name_update.val(),
                        "star": $(that).closest("li").attr("data-star"),
                        "sort": $(that).closest("li").attr("data-sort")
                    },
                    dataType: "json",
                    beforeSend: function() {
                        $(that).attr("data-updating", true).html('<i class="fas fa-spinner fa-spin"></i>');
                    },
                    success: function(data) {
                        // console.log(data.msg);
                        if (data.msg == "item update success") {
                            task_name_update.siblings("p.para").text(task_name_update.val().trim());
                            task_name_update.siblings("p.para").toggleClass("-none");
                            task_name_update.toggleClass("-none");
                            $(that).html('更新');
                            $(that).removeAttr("data-updating").removeAttr("data-edit");
                            alert("更新成功");
                        }
                        
                    },
                    error: function(xhr) {
                        console.log(xhr);
                    },
                    complete: function() {

                    }
                });
            };
        };

    });

    $("ul.task_list").on("click", "button.btn_up, button.btn_down", function(){
        if ($(this).hasClass("btn_up") && !$(this).closest("li").is(':first-child')) {
            let clone_html = $(this).closest("li").clone();
            $(this).closest("li").prev().before(clone_html);
            $(this).closest("li").remove();
        }
        if ($(this).hasClass("btn_down") && !$(this).closest("li").is(':last-child')) {
            let clone_html = $(this).closest("li").clone();
            $(this).closest("li").next().after(clone_html);
            $(this).closest("li").remove();
        }
        reloadSort();
    });

    $("ul.task_list").on("click", "span.star", function() {
        // console.log($(this).attr("data-star"));
        // console.log($(this).closest("div").find("span.star"));
        let click_star = parseInt($(this).attr("data-star"));
        
        let that = this;
        $.ajax({
            url: "https://notes.webmix.cc/ajax/teach/api/patch_star.php",
            type: "PATCH",
            data: {
                "user_id": user_id,
                "item_id": $(that).closest("li").attr("data-id"),
                "star": $(that).attr("data-star")
            },
            dataType: "json",
            beforeSend: function(){
                $(that).closest("div.star_block").append('<div class="temp_loading"><span><i class="fas fa-spinner fa-spin"></i></span></div>');
            },
            success: function(data) {
                if (data.msg == "star update success") {
                    $(that).closest("li").attr("data-star", click_star);
                    $(that).closest("div").find("span.star").each(function(index, item){
                        if (parseInt($(item).attr("data-star")) <= click_star) {
                            $(item).addClass("-on");
                        } else {
                            $(item).removeClass("-on");
                        }
                    });
                }
            },
            error: function(xhr) {
                console.log(xhr);
            },
            complete: function() {
                $(that).closest("div.star_block").find("div.temp_loading").remove();
            }
        });
    });
});