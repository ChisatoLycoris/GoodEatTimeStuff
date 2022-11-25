$(function(){
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
            let task_html = `<li>
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
        }
        
    });


    $("button.btn_empty").on("click", function(){
        
        let r = confirm("確認要移除?");

        if (r) {
            $("ul.task_list").children("li").animate({"opacity": 0}, 1000, "swing", function(){
                $(this).remove();
            });
        }
        
    });

    $("ul.task_list").on("click", "button.btn_delete", function(){
        // console.log("active");
        let r = confirm("確認要移除?");

        if (r) {
            $(this).closest("li").animate({"opacity": 0}, 1000, "swing", function(){
                $(this).remove();
            });
        }
    });

    // 更新待辦事項
    $("ul.task_list").on("click", "button.btn_update", function(){
        // console.log($(this));
        var task_name_update = $(this).closest("li").find("input.task_name_update");
        if (task_name_update.val().trim() == "") {
            alert("請輸入待辦事項");
        } else {
            task_name_update.val(task_name_update.val().trim());
            task_name_update.siblings("p.para").text(task_name_update.val().trim());
            task_name_update.siblings("p.para").toggleClass("-none");
            task_name_update.toggleClass("-none");
        }
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
    });

    $("ul.task_list").on("click", "span.star", function() {
        // console.log($(this).attr("data-star"));
        // console.log($(this).closest("div").find("span.star"));
        var click_star = parseInt($(this).attr("data-star"));
        $(this).closest("div").find("span.star").each(function(index, item){
            if (parseInt($(item).attr("data-star")) <= click_star) {
                $(item).addClass("-on");
            } else {
                $(item).removeClass("-on");
            }
        });
    });
});