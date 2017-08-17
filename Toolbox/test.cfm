<cfprocessingdirective pageencoding="utf-8" />

<cfhttp url="https://static.wixstatic.com/media/6a4a49_e7ad62bef9784345a5384e4b330d3e85~mv2.jpg" getasbinary="false" />

<!--- <cfdump var="#cfhttp#" /> --->

<cfimage action="writeToBrowser" source="#cfhttp.filecontent#" format="png" isBase64="false" width="800" height="600" />