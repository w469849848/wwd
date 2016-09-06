$(function(){
	 $('body').on('click', '#submit-select-shop', function() {
		 var $select = $('.checked-wrap .chk').filter('[checked=checked]');
		 var shops = [];
		 $select.each(function() {
			 var shop = {};
			 var $this = $(this);
			 shop.sShopNO = $this.attr('data-no');
			 shop.sShopName = $this.attr('data-name');
			 shop.sAddress = $this.attr('data-addr');
			 shops.push(shop);
		 });
		 parent.selectShops(shops);
	 });
});