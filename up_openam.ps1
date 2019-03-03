# 環境変数を設定
$vagrant_dir = "C:\Users\banbo\vagrant"
$box_list = Get-Content ${vagrant_dir}\openam_box.csv
$global_status = vagrant global-status
$my_name = $myInvocation.MyCommand.name
# ロガー関数を読みこみ
.${vagrant_dir}\logger.ps1

# box名からidを取得
Function Get-BoxId($box_name){
    $up_box =  $global_status | Select-String $box_name 
    $box_info = $up_box -split " "
    return $box_info[0]
}

# idを指定してマシンを起動
Logger($myname, "INFO", "Process start" )
$box_array = $box_list -split ","
foreach($box_name in $box_array){
   Logger($myname, "INFO", "Booting ${box_name}" )
   $box_id = Get-BoxId $box_name
   vagrant up $box_id > ${vagrant_dir}\vagrant.log
   if ($? -ne "True"){
       Logger($myname, "ERROR", "Booting ${box_name} failed" )
   }
}
Logger($myname, "INFO", "Process end" )
