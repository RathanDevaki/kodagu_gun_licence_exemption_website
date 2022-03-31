<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
$servername="localhost";
$username="root";
$password="";
$dbname="EXEMPTION_KODAGU1";
$table="AdminLogin";
$action=$_POST["action"];
$conn=new mysqli($servername,$username,$password,$dbname);

if($conn->connect_error)
{
    die("Connection Error".$conn->connect_error);
    return;
}

if("GET_ADMIN_LOGIN" == $action){
    $db_data = array();
    if(isset($_POST["user_id"])&&isset($_POST["password"]))
    {
    $user_id=$_POST['user_id'];
    $password=$_POST['password'];
    $sql = "SELECT * from $table WHERE user_id='".$user_id."' AND password='".$password."'";
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
}
if("GET_ADMIN_LOGIN1" == $action){
    $db_data = array();
    $sql = "SELECT * from $table";
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

if("CREATE_TABLE_LOGIN"==$action){
    $sql="CREATE TABLE IF NOT EXISTS $table(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, user_id VARCHAR(100),password varchar(30),user_type varchar(30),PRIMARY KEY(user_id))ENGINE=InnoDB";

    if($conn->query($sql)===TRUE)
    {
        echo "Created Login successfully";
    }
    else
    {
        echo "Error creating table".$conn -> error;
    }
    $conn->close();
    return;
}



?>
