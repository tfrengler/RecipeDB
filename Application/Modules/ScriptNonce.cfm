<cfset NonceValue = application.SecurityManager.GenerateNonce() />
<!--- <cfheader name="Content-Security-Policy" value="script-src 'nonce-#NonceValue#'" /> --->