<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
$servername="localhost";
$username="root";
$password="";
$dbname="EXEMPTION_KODAGU1";
$table="PoliceStation";
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


if("CREATE_TABLE_POLICE_STATION"==$action){

    $sql="CREATE TABLE IF NOT EXISTS $table(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, station_code VARCHAR(10),station_name_en CHAR(30),station_name_ka CHAR(30),taluk_code varchar(30),PRIMARY KEY(station_code),FOREIGN KEY(taluk_code)REFERENCES Taluk(taluk_code)ON DELETE CASCADE ON UPDATE CASCADE)ENGINE=InnoDB";

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

if("GET_STATION" == $action){
    $db_data = array();
    $sql = "SELECT s.sl_no,s.station_code,s.station_name_en,s.station_name_ka,s.taluk_code,t.taluk_name from PoliceStation s LEFT JOIN Taluk t ON s.taluk_code=t.taluk_code ORDER BY s.station_code";
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

if("ADD_STATION"==$action)
{
    $station_code=$_POST["station_code"];
    $station_name_en=$_POST["station_name_en"];
    $station_name_ka=$_POST["station_name_ka"];
    $taluk_code=$_POST["taluk_code"];
    $sql="INSERT INTO $table(station_code,station_name_en,station_name_ka,taluk_code)VALUES('".$station_code."','".$station_name_en."','".$station_name_ka."','".$taluk_code."')";
    $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}
if("UPDATE_STATION"==$action)
{
$constraint=$_POST["constraint"];
 $station_code = $_POST["station_code"];
 $station_name_en = $_POST["station_name_en"];
 $station_name_ka = $_POST["station_name_ka"];
 $taluk_code = $_POST["taluk_code"];
 $sl_no = $_POST["sl_no"];

 $sql="UPDATE $table SET station_code = '".$station_code."', station_name_en='".$station_name_en."',station_name_ka='".$station_name_ka."', taluk_code='".$taluk_code."' where station_code ='".$constraint."' ";
 $result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
}

if("DELETE_STATION" == $action)
{
 $station_code = $_POST["station_code"];
 
 $sql ="DELETE FROM $table WHERE station_code = '".$station_code."' ";

$result=$conn->query($sql);
    echo "Success";
    $conn->close();
    return;
} 

?>
