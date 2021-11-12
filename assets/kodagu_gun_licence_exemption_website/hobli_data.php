<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
$servername="localhost";
$username="root";
$password="";
$dbname="EXEMPTION_KODAGU";
$table="Hobli";
$action=$_POST["action"];
$conn=new mysqli($servername,$username,$password,$dbname);

if($conn->connect_error)
{
    die("Connection Error".$conn->connect_error);
    return;
}

if("GET_TALUK" == $action){
    $db_data = array();
    $sql = "SELECT * from Taluk";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }else{
        echo "error".$conn -> error;
    }
    $conn->close();
    return;
}

if("CREATE_TABLE_HOBLI"==$action){
    $sql="CREATE TABLE IF NOT EXISTS $table(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, hobli_code VARCHAR(10)PRIMARY KEY,hobli_name CHAR(30),taluk_name varchar(30))";

    if($conn->query($sql)===TRUE)
    {
        echo "Create successfully";
    }
    else
    {
        echo "Error creating table".$conn -> error;
    }
    $conn->close();
    return;
}

if("GET_HOBLI" == $action){
    $db_data = array();
    $sql = "SELECT * from $table ";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }else{
        echo "error".$conn -> error;
    }
    $conn->close();
    return;
}
if("ADD_HOBLI"==$action)
{
    $hobli_code=$_POST["hobli_code"];
    $hobli_name=$_POST["hobli_name"];
    $taluk_name=$_POST["taluk_name"];
    $sql="INSERT INTO $table(hobli_code,hobli_name,taluk_name)VALUES('$hobli_code','$hobli_name','$taluk_name')";
    $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}
if("UPDATE_HOBLI"==$action)
{
 $hobli_code = $_POST["hobli_code"];
 $hobli_name = $_POST["hobli_name"];
 $taluk_name = $_POST["taluk_name"];
 $sl_no = $_POST["sl_no"];
 $sql="UPDATE $table SET hobli_code = '$hobli_code', hobli_name='$hobli_name',taluk_name='$taluk_name' where sl_no = $sl_no ";
 $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}

if("DELETE_HOBLI" == $action)
{
 $hobli_code = $_POST["hobli_code"];
 $sl_no = $_POST["sl_no"];
 $sql ="DELETE FROM $table WHERE sl_no = $sl_no ";
  $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
} 



?>
