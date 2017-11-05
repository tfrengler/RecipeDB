<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.roadMap" type="string" default="" />

<section>
	<h1 id="RoadMap-Welcome" class="olive-text-color-center" >Planned changes</h1>
</section>

<section id="RoadMapContainer" class="olive-wrapper-grey-background standard-rounded-corners col-lg-8 col-lg-offset-2" >

	<cfif len(attributes.roadMap) GT 0 >

		<div id="RoadMap" >
			#attributes.roadMap#
		</div>

	<cfelse>
		<div>
			<i>No roadmap...</i>
		</div>
	</cfif>

</section>

</cfoutput>