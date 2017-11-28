<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<section>
	<h1 id="About-Welcome" class="olive-text-color-center" >About / Frequently Asked Questions</h1>
</section>

<section id="About-Container" class="olive-wrapper-grey-background standard-rounded-corners col-lg-8 col-lg-offset-2 standard-box-shadow" >

	<h3>So what's this site for?</h3>

	<p>In a nutshell it's a digital cookbook. It's a place where you, as a user, can add, edit and find recipes.</p>

	<h3>Okay, so how does it work? Just the basics please</h3>

	<p>
		Simply put your workflow will be like this:
		<ul>
			<li>You go to <b>Add recipe</b>, give your new recipe a name, and click the <b>ADD</b>-button.</li>
			<li>You're now in your new recipe. You can click on the edit-button (the little disk-icon in the toolbar) and then change the description, ingredients and instructions. Don't forget to save your changes of course.</li>
			<li>You can also make your recipe public by clicking the <b>CHANGE VISIBILITY</b>-button. By default your new recipes are only visible to you. You can also change it back later if you want to make them private again.</li>
			<li>From the main menu you can click <b>Find recipes</b> to get a list of recipes. This includes both your own and the public ones.</li>
			<li>The person who creates a recipe is the owner of it. No one else can edit the recipe in any way.</li>
		</ul>
	</p>

	<h3>That's neat but aren't there already a billion sites like this?</h3>

	<p>Yes, there are plenty of places like this, with more features, and undoubtedly a better interface. But I felt like making my own version. My inspiration for things I have built - including this site - is usually that I want to make a simplified version. I like websites and designs that are fairly straightforward and to the point. No extra fat so to say.</p>

	<p>When I come across a website that does something I am interested in using, they often have a tonne of features or are very flashy, with lots of animations and similar tricks. This is not a criticism, but usually I just want to use a fraction of the things the site can do. This makes me want to flex my creative muscles and make my own simple version with just the stuff I want or need.</p>

	<h3>Why did you decide to make this?</h3>

	<p>This particular creation was inspired by Carlette, my wife. I was looking for a new hobby project and she was complaining about how recipes she had either bookmarked directly or put on her Pinterest disappeared. Links were broken, blog posts were removed or renamed and so she lost access to favorite recipes of hers. That gave me the idea to make an easy to use database where she could store her recipes. Since it's created and maintained by me there's no risk of loosing recipes.</p>

	<h3>What's your goal? What's the scope like? Sell in 10 years for a few million to Google?</h3>

	<p>I have zero desire for this to ever go professional, no matter how good it is (or gets). This is my little personal hobby project; the first of its kind that I let people other than myself or Carlette use. And it will only ever be used by friends and family - people I know and trust. If I were to go pro, or even let random people on the net sign up for it, it brings a whole host of considerations and challenges with it. Such as security of the site, user expectations, a system for tracking issues, expectations of fixes and new features... and I'd probably have to have it hosted at a proper datacenter rather than in my living room.</p>

	<p>From a technical perspective - in terms of features and compatibility - you'll find more detailed notes about that over at <b>Planned changes</b>. I can say already though that it's not optimized for phones.</p>

	<h3>Do you actually have any idea what you are doing? Is it all hastily thrown together spaghetti code?</h3>

	<p>If you're asking if I am a professional developer: no. I do work in IT but as a software tester. I have no educational background in programming or software development either. The programming knowledge I have is all self-taught and I started doing HTML within the first 2 years of working for the company where I am now, later expanding into scripting and then backend programming.</p>

	<p>Due to the nature of my workplace I have done a little bit of professional programming and a lot of my knowledge of the development process, programming paradigms, database setups, code versioning and so on comes from my work. Aside from that I am just an enthusiastic amateur who has a passion for learning and trying to develop stuff. I prefer to do this as a hobby rather than professionally, where I am in control: doing it at my own tempo, setting my own rules and goals and temper user expectations.</p>

	<p>All in all while not a pro I do generally understand pretty much everything I do and use. I love trying to at least grasp the essentials of the principles and things I use, even if I don't always completely get how it works. Coming to the table as a professional tester also means I have an eye for detail and my stuff tends to be very robust. I think very far ahead, re-iterate and test a lot while developing. My code tends to be easily maintainable and extendable. Consider that a fair tradeof for my lack of design and user friendly UI-skills.</p>

	<h3>So is it using a boatload of libraries, frameworks and templates to get quick results without you knowing how it actually works?</h3>

	<p>In keeping with my principles of making things simple - while having the project serve as a learning experience as well - I do use some libraries and frameworks, but it's not overloaded with them. In the beginning (before this project) I wrote a lot of things from scratch. Didn't even use jQuery! Yes, like others before me I have also built my own custom AJAX- and dialog/pop-up creation-methods in the past and while educational I'll never do that again and frankly neither should anyone else in the long wrong who value their sanity and productivity. Understanding why things work the way they do before using a library or framework is great. Re-inventing the wheel (perhaps continously) for no good reason is crazy.</p>

	<p>The ones I use are for embellishments and for quality of life stuff that I really can't be arsed to deal with myself. There's nothing used as factory or for templating. You can quickly get some very impressive sites up and running using templates and frameworks these days. That's cool, especially if you're looking to get results quickly. For me personally these projects are learning experiences and a chance for me to flex my creative muscles without professional pressure. That means I often prefer to build stuff from scratch myself at least once. That way I learn something and gain a greater understanding and appreciation of what a framework can do for you. Long term I find that building (almost) everything yourself is probably just for bragging rights - and that's cool too if that's your goal.</p>

	<h3>So what is the actual architecture behind it?</h3>

	<p>If you're really curious then let's get technical:

		<ul>
			<li><b>SERVER MACHINE:</b> An almost decade old Intel Core i7 with 6GB of DDR3 RAM, a decade old SATA1 harddisk, running Windows, which is standing in the corner of my living room</li>
			<li><b>WEBSERVER:</b> nginx</li>
			<li><b>BACKEND LANGUAGE:</b> Coldfusion, written in CFML, running on Lucee</li>
			<li><b>DATABASE:</b> Postgresql</li>
			
			<li><b>FRAMEWORKS AND LIBRARIES:</b>
				<ul>
					<li><b>Backend:</b> none. It's an MVC framework of my own making.</li>
					<li><b>Frontend HTML:</b> Bootstrap. Mostly used for responsive design reasons. There's no templating of any kind. I write all my own HTML pages from scratch</li>
					<li><b>Frontend CSS:</b> Font Awesome, Bootstrap, Google Fonts and jQuery UI</li>
					<li><b>Frontend JS:</b> jQuery, DataTables and TinyMCE. The first for hopefully obvious quality of life reasons and the second because a client-side realtime searchable tables are awesome and I really really really don't want to build that myself. The latter because who in their right mind would ever not use a third party library for text editors or, stars forbid, make one themselves?</li>
				</ul>
			</li>
		</ul>
	</p>

</section>

</cfoutput>