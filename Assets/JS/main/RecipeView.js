RecipeDB.RecipeView = {};

RecipeDB.RecipeView.OpenCloseSection = function(Caller) {
	var HeaderSection = Caller;
	var BodySection = Caller.nextElementSibling;

	if ( $(BodySection).css("display") == "block" ) {
		$(BodySection).animate({height: 0}, 500, function() {
			$(BodySection).hide();
			$(HeaderSection).css({display: "block", "text-align": "center"});
		});
	}
	else {
		$(BodySection).show();
		$(BodySection).animate({height: RecipeDB[BodySection.id].Height}, 500, function() {
			$(BodySection).css("height", "");
			$(HeaderSection).css({display: "inline-block", "text-align": ""});
		});
	}
};

$(document).ready(function() {
	RecipeDB["Description-Body"].Height = parseFloat( $("#Description-Body").css("height") );
	RecipeDB["Ingredients-Body"].Height = parseFloat( $("#Ingredients-Body").css("height") );
	RecipeDB["Instructions-Body"].Height = parseFloat( $("#Instructions-Body").css("height") );
	RecipeDB["Comments-Body"].Height = parseFloat( $("#Comments-Body").css("height") );
	RecipeDB["Status-Body"].Height = parseFloat( $("#Status-Body").css("height") );

	$('.recipe-header').click(function() {
		RecipeDB.RecipeView.OpenCloseSection(this)
	});
});