<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
$servername="localhost";
$username="root";
$password="";
$dbname="EXEMPTION_KODAGU1";
$table="Village";
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
if("GET_HOBLI" == $action){
    $db_data = array();
    $sql = "SELECT * from Hobli";
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
if("GET_VA_CIRCLE" == $action){
    $db_data = array();
    $sql = "SELECT * from VACircle";
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

if("CREATE_TABLE_VILLAGE"==$action){
    $sql="CREATE TABLE IF NOT EXISTS Village(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, village_code VARCHAR(10),village_name CHAR(30),taluk_code varchar(20),hobli_code varchar(30),va_circle_code varchar(30),PRIMARY KEY(village_code),FOREIGN KEY(hobli_code)REFERENCES Hobli(hobli_code),FOREIGN KEY(taluk_code)REFERENCES Taluk(taluk_code),FOREIGN KEY(va_circle_code)REFERENCES VACircle(va_circle_code) ON DELETE CASCADE ON UPDATE CASCADE)ENGINE=InnoDB";

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

if("GET_VILLAGE" == $action){
    $db_data = array();
    $sql = "SELECT va.sl_no,va.village_code,va.village_name,va.va_circle_code,va.taluk_code,va.hobli_code,t.taluk_name,h.hobli_name,v.va_circle_name from Village va INNER JOIN Taluk t ON va.taluk_code=t.taluk_code INNER JOIN Hobli h ON h.hobli_code=va.hobli_code INNER JOIN VACircle v ON v.va_circle_code=va.va_circle_code";
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
if("ADD_VILLAGE"==$action)
{
    $village_code=$_POST["village_code"];
    $village_name=$_POST["village_name"];
    $hobli_code =$_POST["hobli_code"];
    $taluk_code=$_POST["taluk_code"];
    $va_circle_code=$_POST["va_circle_code"];
    $sql="INSERT INTO $table(village_code,village_name,hobli_code,taluk_code,va_circle_code)VALUES('".$village_code."','".$village_name."','".$hobli_code."','".$taluk_code."','".$va_circle_code."')";
    $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}
if("UPDATE_VILLAGE"==$action)
{
 
 $village_code=$_POST["village_code"];
 $village_name=$_POST["village_name"];
 $hobli_code =$_POST["hobli_code"];
 $taluk_code=$_POST["taluk_code"];
 $va_circle_code=$_POST["va_circle_code"];
 $sl_no = $_POST["sl_no"];
 $constraints=$_POST["constraints"];
 
 $sql="UPDATE $table SET village_code='".$village_code."',village_name='".$village_name."', taluk_code='".$taluk_code."' ,hobli_code = '".$hobli_code."',va_circle_code = '".$va_circle_code."' where village_code = '".$constraints."' ";
 $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}

if("DELETE_VILLAGE" == $action)
{
 $va_circle_code=$_POST["va_circle_code"];
 $sl_no = $_POST["sl_no"];
 $constraints=$_POST["constraints"];
 $sql ="DELETE FROM $table WHERE sl_no = '".$sl_no."' ";
  $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
} 

?>
