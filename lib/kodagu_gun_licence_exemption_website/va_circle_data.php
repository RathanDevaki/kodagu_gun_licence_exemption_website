<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
$servername="localhost";
$username="root";
$password="";
$dbname="EXEMPTION_KODAGU1";
$table="VACircle";
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
    $tal=$_POST["taluk_code_"];
    $sql = "SELECT * from Hobli where taluk_code='".$tal."' ";
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

if("CREATE_TABLE_VA_CIRCLE"==$action){
    $sql="CREATE TABLE IF NOT EXISTS $table(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, va_circle_code VARCHAR(50),va_circle_name CHAR(100),va_circle_name_ka CHAR(100),taluk_code varchar(100),hobli_code varchar(100),PRIMARY KEY(va_circle_code),FOREIGN KEY(taluk_code)REFERENCES Taluk(taluk_code),FOREIGN KEY(hobli_code)REFERENCES Hobli(hobli_code)ON DELETE CASCADE ON UPDATE CASCADE)ENGINE=InnoDB";

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

if("GET_VA_CIRCLE" == $action){
    $db_data = array();
    $sql = "SELECT va.sl_no,va.va_circle_code,va.va_circle_name,va.va_circle_name_ka,va.va_circle_code,va.taluk_code,va.hobli_code,t.taluk_name,h.hobli_name from VACircle va INNER JOIN Taluk t ON va.taluk_code=t.taluk_code INNER JOIN Hobli h ON h.hobli_code=va.hobli_code";
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
if("ADD_VA_CIRCLE"==$action)
{
    $va_circle_code=$_POST["va_circle_code"];
    $va_circle_name=$_POST["va_circle_name"];
    $hobli_code =$_POST["hobli_code"];
    $taluk_code=$_POST["taluk_code"];
    $va_circle_name_ka=$_POST["va_circle_name_ka"];
    $sql="INSERT INTO $table(va_circle_code,va_circle_name,va_circle_name_ka,hobli_code,taluk_code)VALUES('".$va_circle_code."','".$va_circle_name."','".$va_circle_name_ka."','".$hobli_code."','".$taluk_code."')";
    $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}
if("UPDATE_VA_CIRCLE"==$action)
{
 
 $va_circle_code=$_POST["va_circle_code"];
 $va_circle_name=$_POST["va_circle_name"];
 $va_circle_name_ka=$_POST["va_circle_name_ka"];
 $hobli_code =$_POST["hobli_code"];
 $taluk_code=$_POST["taluk_code"];
 $sl_no = $_POST["sl_no"];
 $constraints=$_POST["constraints"];
 
 $sql="UPDATE $table SET va_circle_code = '".$va_circle_code."', va_circle_name='".$va_circle_name."', va_circle_name_ka='".$va_circle_name_ka."',taluk_code='".$taluk_code."' ,hobli_code = '".$hobli_code."' where va_circle_code = '".$constraints."' ";
 $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}

if("DELETE_VA_CIRCLE" == $action)
{
 $va_circle_code=$_POST["va_circle_code"];
 $sl_no = $_POST["sl_no"];
 $sql ="DELETE FROM $table WHERE sl_no = '".$sl_no."' ";
  $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
} 



?>
