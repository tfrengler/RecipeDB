<style type="text/css">
	
	.error-box {
		border-style: solid;
		border-width: 1px;
		display: block;
		font-weight: bold;
		padding: 1em;
		margin-bottom: 1em;
		border-radius: 0.3em;
		max-width: 60%;
		color: #a94442;
		background-color: #f2dede;
		position: fixed;
		left: 0;
		right: 0;
		top: 1em;
		margin: 0 auto;
	}

	.error-box section {
		text-align: center;
	}
</style>

<cfoutput>

<div id="Notification-Box" class="error-box" >
	<section>
		Ooops, something went wrong. Sorry about that!
		<br/><br/>
		A team of highly trained monkeys has been dispatched to deal with the situation.
		<br>
		If you see them, show them this information:
	</section>
	<hr/>
	<code>
		<div><u>MESSAGE:</u> #left(cfcatch.message, 100)#</div>
		<div><u>DETAIL:</u> #cfcatch.detail#</div>
		<br/>
		<div><u>STACKTRACE:</u></div>
		<cfloop array=#cfcatch.TagContext# index="currentContext" >
			<div>#currentContext.codePrintHTML#</div>
			<div>#currentContext.Raw_Trace#</div>
		</cfloop>
	</code>
</div>

</cfoutput>