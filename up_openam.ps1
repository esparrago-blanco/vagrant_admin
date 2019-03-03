# ���ϐ���ݒ�
$vagrant_dir = "C:\Users\banbo\vagrant"
$box_list = Get-Content ${vagrant_dir}\openam_box.csv
$global_status = vagrant global-status
$my_name = $myInvocation.MyCommand.name
# ���K�[�֐���ǂ݂���
.${vagrant_dir}\logger.ps1

# box������id���擾
Function Get-BoxId($box_name){
    $up_box =  $global_status | Select-String $box_name 
    $box_info = $up_box -split " "
    return $box_info[0]
}

# id���w�肵�ă}�V�����N��
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
