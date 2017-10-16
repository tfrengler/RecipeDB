<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.roadMap" type="string" default="" />

<h1 id="RoadMap-Welcome" class="olive-text-color-center" >Planned changes</h1>

<section id="RoadMapContainer" class="olive-wrapper-grey-background col-md-8 col-md-offset-2" >

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