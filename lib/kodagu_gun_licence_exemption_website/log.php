<?php 
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type:application/json;charset=utf-8"); 
header("Access-Control-Allow-Methods: POST");
  
  $db = "EXEMPTION_KODAGU1"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host
	
  $return["error"] = false;
  $return["message"] = "";
  $return["success"] = false;
  $table="AdminLogin";
  $action=$_POST["action"];
  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
 

/*if($link->connect_error)
{
    die("Connection Error".$link->connect_error);
    return;
}
  if("CREATE_TABLE_LOGIN"==$action)
  {
    $sql="CREATE TABLE IF NOT EXISTS $table(sl_no INT AUTO_INCREMENT UNIQUE KEY not null, user_id VARCHAR(100) PRIMARY KEY,password varchar(30),full_name varchar(100),user_type varchar(50))ENGINE=InnoDB";

    if($link->query($sql)===TRUE)
    {
        echo "Created Login successfully";
    }
    else
    {
        echo "Error creating table".$link -> error;
    }
    $link->close();
    return;
}*/


  if(isset($_POST["user_id"]) && isset($_POST["password"])){
       //checking if there is POST data

       $username = $_POST["user_id"];
       $password = $_POST["password"];

       $username = mysqli_real_escape_string($link, $username);
       //escape inverted comma query conflict from string

       $sql = "SELECT * FROM $table WHERE user_id = '".$username."' ";
       //building SQL query
       $res = mysqli_query($link, $sql);
       $numrows = mysqli_num_rows($res);
       //check if there is any row
       if($numrows > 0){
           //is there is any data with that username
           $obj = mysqli_fetch_object($res);
           //get row as object
         
          if($password == $obj->password){
               $return["success"] = true;
               $return["user_id"] = $obj->user_id;
               $return["full_name"] = $obj->full_name;
               $return["address"] = $obj->address;
          }else{
               $return["error"] = true;
               $return["message"] = "Your Password is incorrect.";
           }
       }else{
           $return["error"] = true;
           $return["message"] = 'User doesn\'t exists';
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link);

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>
