<?php 
// --
class M_Meal extends Model {
    // --
    public function __construct() {
		parent::__construct();
    }
    public function get_meal() {
      // --
      try {
          // --
              $sql = 'SELECT 

                      id_meal,
                      meal_sku,
                      meal_name,
                      meal_description,
                      id_category,
                      meal_price,
                      categories.description
                     
                  FROM meal
                  JOIN categories ON meal.id_category=categories.id;
                  
           ';
          // --
          $result = $this->pdo->fetchAll($sql);
          // --
          if ($result) {
              // --
              $response = array('status' => 'OK', 'result' => $result);
          } else {
              // --
              $response = array('status' => 'ERROR', 'result' => array());
          }
      } catch (PDOException $e) {
          // --
          $response = array('status' => 'EXCEPTION', 'result' => $e);
      }
      // --
      return $response;
    }
} 