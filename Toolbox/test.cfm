<cfscript>

test = Components.Localizer::GetBackendDateTimeFromDate(now());

writeOutput("<br/>");
writeOutput(test);

test2 = dateConvert("utc2Local", test);

writeOutput("<br/>");
writeOutput(test2);

test3 = lsDateTimeFormat(test2, "dd-mm-yyyy HH:nn:ss");

writeOutput("<br/>");
writeOutput(test3);

</cfscript>