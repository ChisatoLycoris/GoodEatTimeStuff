$(function(){

    function calculateCart() {
        // console.log($("thead.-on").next("tbody").find("td.cart__price"));
        // 僅針對打開的表個計算
        $("div.cart__total li.cart__subtotal").remove();

        let totalAmount = 0;
        let totalQty = 0;
        $("table.-on").children("tbody").find("td.cart__price").each(function(index, item){
            let price = parseInt($(item).siblings("td.product__cart__item").find("h5").attr("price"));
            let quantity = parseInt($(item).siblings("td.quantity__item").find("input").val());
            let subtotal = price * quantity;

            $(item).html(`NTD ${subtotal}`);
            $(item).attr("subtotal", subtotal);
            // console.log("777");
            totalAmount += subtotal;
            totalQty += quantity;

            let itemName = $(this).siblings("td.product__cart__item").find("h6").text();
            // console.log(itemName);
            let li_subtotal = `<li class="cart__subtotal">${itemName} <span>${subtotal}</span></li>`;
            if (subtotal != 0) {
                $("li.cart__total__divider").before(li_subtotal);
            }
        });
        
        $("li.cart__final__amount > span").text(`NTD ${totalAmount}`);
        $("div.header__top__right__cart div.cart__price span").text(`${totalQty}筆`);
        
        if ($("li.cart__final__amount").is(":nth-child(2)")) {
            $("li.cart__final__amount").removeClass("-on");
        } else {
            $("li.cart__final__amount").addClass("-on");
        }
        
    }

    calculateCart();

    // 縮合不同餐廳內的購物車內容
    $("div.shopping__cart__table").on("click", "thead.prod__cart__heads",function(){
        // console.log($(this).closest("table"));
        // console.log($(this).next("tbody.prod__cart__items"));

        // 關閉其他已打開的表格關閉
        let otherOpenTable = $(this).closest("table").siblings(".-on");
        otherOpenTable.children("tbody.prod__cart__items").find("tr").slideToggle(1);
        otherOpenTable.toggleClass("-on");

        // 縮核備點擊餐廳的購物車內容
        let targetTable = $(this).next("tbody.prod__cart__items");
        $(this).closest("table").toggleClass("-on");
        targetTable.find("tr").slideToggle(1);

        // 金額重新計算
        calculateCart();
        if ($("#use__coupon").hasClass("coupon__using")) {
            $("#use__coupon").html("使用");
            $("#use__coupon").removeClass("coupon__using");
            $("div.cart__discount__alert span").removeClass("-on");
            $("div.cart__total li.coupon__using").remove();
            $("div.nice-select li.selected").removeClass("selected");
            $("div.nice-select li").first().addClass("selected");
            $("div.nice-select span.current").text($("div.nice-select li.selected").text());
        }
    });
    
    // 刪除購物車內容
    $("div.shopping__cart__table").on("click", "span.icon_close",function(){
        // console.log(this);
        let target = $(this).closest("tr");
    
        if (target.is(":first-child") && target.is(":last-child")) {
            // console.log("aaa");
            target.closest("table").fadeOut(500, function(){
                $(this).remove();
                calculateCart();
            });
        } else {
            target.fadeOut(500, function(){
                // console.log(this);
                // console.log($(this).is(":last-child"));
                
                // if($(this).is(":first-child") && $(this).is(":last-child")) {
                //     $(this).closest("table").remove();
                // }
                $(this).remove();
                calculateCart();
            });
        }
        
    
    });
    
    // 使用折價券按鈕功能
    $("#use__coupon").on("click", function(){
    
        // console.log(this);
        let selected__coupon = $(this).closest("form").find("div.nice-select li.selected").attr("data-value");
        // console.log(selected__coupon);
        // 若未選擇折價券，直接回傳，不執行後方程式碼
        if (selected__coupon == "") {
            return;
        }
    
        let coupon__discount = - 50;
        let li__coupon__discount = 
            `<li class="coupon__using">
                折價券優惠 
                <span>${coupon__discount}</span>
            </li>`;
        
        if($(this).hasClass("coupon__using")){
            /**
             * 若目前已有折價券使用中，則取消使用折價券
             * 取消顯示警告訊息
             * */
            // console.log("using");
            $("div.cart__total li.coupon__using").fadeOut(500, function(){
                $(this).remove();
            });
            $(this).html("使用");
            $("div.cart__discount__alert span").removeClass("-on");
            $("div.nice-select li.selected").removeClass("selected");
            $("div.nice-select li").first().addClass("selected");
            $("div.nice-select span.current").text($("div.nice-select li.selected").text());
        } else {
            /**
             * 若目前尚未有折價券使用中，則使用折價券
             * */
            // console.log("not using");
            // console.log($("div.cart__total li.cart__orginal__amount"));
            $("div.cart__total li.cart__final__amount").before(li__coupon__discount);
            $("div.cart__total li.coupon__using").fadeIn(500);
            $(this).html("取消");
            
        }
        
        $(this).toggleClass("coupon__using");
        
    });

    // 配合折價券按鈕功能遮蔽折價券選擇
    $("div.selected__coupon__mask").on("click", function(e){
        if($("button#use__coupon").hasClass("coupon__using")){
            // console.log("using");
            // 若已有折價券使用中，則停止冒泡事件，不讓使用者再次選擇折價券
            // 需先取消折價券後再使用
            e.stopPropagation();
            $("div.cart__discount__alert span").addClass("-on");
        } else {
            // console.log("not using");
        }
    });

    // 數量變動重新計算金額
    /*-------------------
		Quantity change
	--------------------- */
    var proQty = $('.pro-qty');
    // proQty.prepend('<span class="dec qtybtn">-</span>');
    // proQty.append('<span class="inc qtybtn">+</span>');
    proQty.on('click', '.qtybtn', function () {
        calculateCart();
        // console.log(123);
    });
    
});

