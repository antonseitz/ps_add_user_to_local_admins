param (
[string] $azure_account,
[string] $local_account,
[string] $domain

)

if( $domain -and ($azure_account -or $local_account )){

$member= net localgroup administratoren

if($azure_account){
$username=$azure_account.tolower().split("@")
$username_ohne_domain=$username[0]
$account = "AzureAD\" + $azure_account

$test=$domain + "\" + $username_ohne_domain


}
if($local_account){
    $username_ohne_domain=$local_account
    $account = $local_account
    $test=$account
}




if( $member.contains( $test) ){
	$azure_account + " already member of admin group"
}
else {
    "User " + $account + " hinzufügen.."
	
	net localgroup administratoren /add "$account"
	if ($LASTEXITCODE -ne 0){
"..ERROR"
}else {"..SUCCESS"}
	
}




}else {

"Script adds user to locale admin group 
USAGE: 

-azure_account user@company.com   OR   -localaccount  loc_admin

AND

-domain (like COMPANY)"
}