<?php
// --
class C_Reception extends Controller
{

  // --
  public function __construct()
  {
    parent::__construct();
  }

  // --
  public function index()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    $this->functions->check_permissions($this->segment->get('modules'), 'Reception');
    // --
    $this->view->set_js('index');       // -- Load JS
    $this->view->set_menu(array('modules' => $this->segment->get('modules'), 'view' => 'Reception')); // -- Active Menu
    $this->view->set_view('index');     // -- Load View  
  }
  public function get_rooms()
  {
    $this->functions->validate_session($this->segment->get('isActive'));
    $request = $_SERVER['REQUEST_METHOD'];

    if ($request === 'GET') {
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }

      $obj = $this->load_model('Reception');
      $response = $obj->get_rooms();

      switch ($response['status']) {
        case 'OK':
          $json = array(
            'status' => 'OK',
            'type' => 'success',
            'msg' => 'Listado de registros encontrados.',
            'data' => $response['result']
          );
          break;

        case 'ERROR':
          $json = array(
            'status' => 'ERROR',
            'type' => 'warning',
            'msg' => 'No se encontraron registros en el sistema.',
            'data' => array(),
          );
          break;

        case 'EXCEPTION':
          $json = array(
            'status' => 'ERROR',
            'type' => 'error',
            'msg' => $response['result']->getMessage(),
            'data' => array()
          );
          break;
      }
    } else {
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    header('Content-Type: application/json');
    echo json_encode($json);
  }

  //--

  public function get_room_by_status()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'GET') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      // --
      if (!empty($input['room_status'])) {
        // --
        $obj = $this->load_model('Reception');
        // --
        $bind = array('room_status' => $input['room_status']);
        // --
        $response = $obj->get_room_by_status($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }



  public function get_room_by_id()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'GET') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      // --
      if (!empty($input['id_room'])) {
        // --
        $obj = $this->load_model('Reception');
        // --
        $bind = array('id_room' => intval($input['id_room']));
        // --
        $response = $obj->get_room_by_id($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }


  public function get_guest()
  {
    $this->functions->validate_session($this->segment->get('isActive'));
    $request = $_SERVER['REQUEST_METHOD'];

    if ($request === 'GET') {
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      if (!empty($input['document_type'])) {

        $obj = $this->load_model('Reception');
        $bind = array(
          'document_type' => $input['document_type'], // Puede ser 'DNI' o 'RUC'
        );
        $response = $obj->get_guest($bind);

        switch ($response['status']) {
          case 'OK':
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            break;

          case 'ERROR':
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            break;

          case 'EXCEPTION':
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            break;
        }
      }
    } else {
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    header('Content-Type: application/json');
    echo json_encode($json);
  }



  public function service_room()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'GET') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      // --
      if (!empty($input['id_food']) && !empty($input['id_accesory'])) {
        // --
        $obj = $this->load_model('Reception');
        // --
        $bind = array('id_food' => intval($input['id_food']), 'id_accesory' => intval($input['id_accesory']));
        // --
        $response = $obj->service_room($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }

  public function create_guest_reservation()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'POST') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_POST);
      }
      // --
      if (!empty($input['document_type']) && !empty($input['document_number']) && !empty($input['first_names']) && !empty($input['last_names']) && !empty($input['address']) && !empty($input['company_name'])) {
        // --
        $document_type = $this->functions->clean_string($input['document_type']);
        $document_number = $this->functions->clean_string($input['document_number']);
        $first_names = $this->functions->clean_string($input['first_names']);
        $last_names = $this->functions->clean_string($input['last_names']);
        $address = $this->functions->clean_string($input['address']);
        $company_name = $this->functions->clean_string($input['company_name']);
        // --
        $bind = array('document_type' => $document_type, 'document_number' => $document_number, 'first_names' => $first_names, 'last_names' => $last_names, 'address' => $address, 'company_name' => $company_name);
        // --
        $obj = $this->load_model('Reception');
        $response = $obj->create_guest_reservation($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Registro almacenado en el sistema con éxito.',
              // 'msg' => ,
              'data' => array()
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No fue posible guardar el registro ingresado, verificar.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }


  public function create_reservation()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'POST') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_POST);
      }
      // --
      if (!empty($input['checkin_date']) && !empty($input['checkin_time']) && !empty($input['checkout_date']) && !empty($input['checkout_time']) && !empty($input['id_room']) && !empty($input['id_guest']) && !empty($input['status']) && !empty($input['payment_room']) && !empty($input['pre_payment'])) {
        // --
        $checkin_date = $this->functions->clean_string($input['checkin_date']);
        $checkin_time = $this->functions->clean_string($input['checkin_time']);
        $checkout_date = $this->functions->clean_string($input['checkout_date']);
        $checkout_time = $this->functions->clean_string($input['checkout_time']);
        $id_room = $this->functions->clean_string($input['id_room']);
        $id_guest = $this->functions->clean_string($input['id_guest']);
        $status = $this->functions->clean_string($input['status']);
        $payment_room = $this->functions->clean_string($input['payment_room']);
        $pre_payment = $this->functions->clean_string($input['pre_payment']);
        // --
        $bind = array('checkin_date' => $checkin_date,  'checkin_time' => $checkin_time, 'checkout_date' => $checkout_date, 'checkout_time' => $checkout_time, 'id_room' => $id_room, 'id_guest' => $id_guest, 'status' => $status, 'payment_room' => $payment_room, 'pre_payment' => $pre_payment);
        // --
        $obj = $this->load_model('Reception');
        $response = $obj->create_reservation($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Registro almacenado en el sistema con éxito.',
              // 'msg' => ,
              'data' => array()
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No fue posible guardar el registro ingresado, verificar.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }

public function create_reservation_free(){
  // --
  $this->functions->validate_session($this->segment->get('isActive'));
  // --
  $request = $_SERVER['REQUEST_METHOD'];
  // --
  if ($request === 'POST') {
    // --
    $input = json_decode(file_get_contents('php://input'), true);
    if (empty($input)) {
      $input = filter_input_array(INPUT_POST);
    }
    // --
    if (!empty($input['checkin_date']) && !empty($input['checkin_time']) &&  !empty($input['id_room']) && !empty($input['id_guest']) && !empty($input['status'])) {
      // --
      $checkin_date = $this->functions->clean_string($input['checkin_date']);
      $checkin_time = $this->functions->clean_string($input['checkin_time']);
      $id_room = $this->functions->clean_string($input['id_room']);
      $id_guest = $this->functions->clean_string($input['id_guest']);
      $status = $this->functions->clean_string($input['status']);
      // --
      $bind = array('checkin_date' => $checkin_date,  'checkin_time' => $checkin_time, 'id_room' => $id_room, 'id_guest' => $id_guest, 'status' => $status);
      // --
      $obj = $this->load_model('Reception');
      $response = $obj->create_reservation_free($bind);
      // --
      switch ($response['status']) {
          // --
        case 'OK':
          // --
          $json = array(
            'status' => 'OK',
            'type' => 'success',
            'msg' => 'Registro almacenado en el sistema con éxito.',
            // 'msg' => ,
            'data' => array()
          );
          // --
          break;

        case 'ERROR':
          // --
          $json = array(
            'status' => 'ERROR',
            'type' => 'warning',
            'msg' => 'No fue posible guardar el registro ingresado, verificar.',
            'data' => array(),
          );
          // --
          break;

        case 'EXCEPTION':
          // --
          $json = array(
            'status' => 'ERROR',
            'type' => 'error',
            'msg' => $response['result']->getMessage(),
            'data' => array()
          );
          // --
          break;
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'warning',
        'msg' => 'No se enviaron los campos necesarios, verificar.',
        'data' => array()
      );
    }
  } else {
    // --
    $json = array(
      'status' => 'ERROR',
      'type' => 'error',
      'msg' => 'Método no permitido.',
      'data' => array()
    );
  }

  // --
  header('Content-Type: application/json');
  echo json_encode($json);
}

  public function get_rooms_price()
  {
    $this->functions->validate_session($this->segment->get('isActive'));
    $request = $_SERVER['REQUEST_METHOD'];

    if ($request === 'GET') {
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      if (!empty($input['type_name'])) {

        $obj = $this->load_model('Reception');
        $bind = array('type_name' => $input['type_name']);
        $response = $obj->get_rooms_price($bind);

        switch ($response['status']) {
          case 'OK':
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            break;

          case 'ERROR':
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            break;

          case 'EXCEPTION':
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            break;
        }
      }
    } else {
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    header('Content-Type: application/json');
    echo json_encode($json);
  }

  public function update_state_reservation()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'POST') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_POST);
      }
      // --
      if (
        !empty($input['id_room']) &&
        !empty($input['room_status'])
      ) {
        // --
        $id_room = $this->functions->clean_string($input['id_room']);
        $room_status = $this->functions->clean_string($input['room_status']);
        // --
        $bind = array(
          'id_room' => $id_room,
          'room_status' => $room_status
        );
        // --
        $obj = $this->load_model('Reception');
        $response = $obj->update_state_reservation($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Registro actualizado en el sistema con éxito.',
              'data' => array()
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No fue posible guardar el registro ingresado, verificar.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }
    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }

  public function update_state_timer()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'POST') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_POST);
      }
      // --
      if (
        !empty($input['id_reservation']) &&
        !empty($input['room_status']) &&
        !empty($input['id_room'])
      ) {
        // --
        $id_reservation = $this->functions->clean_string($input['id_reservation']);
        $room_status = $this->functions->clean_string($input['room_status']);
        $id_room = $this->functions->clean_string($input['id_room']);
        // --
        $bind = array(
          'id_reservation' => $id_reservation,
          'room_status' => $room_status,
          'id_room' => $id_room
        );
        // --
        $obj = $this->load_model('Reception');
        $response = $obj->update_state_timer($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Registro actualizado en el sistema con éxito.',
              'data' => array()
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No fue posible guardar el registro ingresado, verificar.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }
    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }









  public function get_reservation_room()
  {
    $this->functions->validate_session($this->segment->get('isActive'));
    $request = $_SERVER['REQUEST_METHOD'];

    if ($request === 'GET') {
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      if (!empty($input['id_room'])) {

        $obj = $this->load_model('Reception');
        $bind = array('id_room' => $input['id_room']);
        $response = $obj->get_reservation_room($bind);

        switch ($response['status']) {
          case 'OK':
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Listado de registros encontrados.',
              'data' => $response['result']
            );
            break;

          case 'ERROR':
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No se encontraron registros en el sistema.',
              'data' => array(),
            );
            break;

          case 'EXCEPTION':
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            break;
        }
      }
    } else {
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    header('Content-Type: application/json');
    echo json_encode($json);
  }


  public function clean_rooms()
  {
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'POST') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_POST);
      }
      // --
      if (
        !empty($input['id_room'])
      ) {
        // --
        $id_room = $this->functions->clean_string($input['id_room']);
        // --
        $bind = array(
          'id_room' => $id_room
        );
        // --
        $obj = $this->load_model('Reception');
        $response = $obj->clean_rooms($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Registro actualizado en el sistema con éxito.',
              'data' => array()
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'No fue posible guardar el registro ingresado, verificar.',
              'data' => array(),
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }
    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }


  public function date_reservation()
  {
    // --
    $this->functions->validate_session($this->segment->get('isActive'));
    // --
    $request = $_SERVER['REQUEST_METHOD'];
    // --
    if ($request === 'GET') {
      // --
      $input = json_decode(file_get_contents('php://input'), true);
      if (empty($input)) {
        $input = filter_input_array(INPUT_GET);
      }
      // --
      if (
        !empty($input['id_room'])  &&
        !empty($input['checkin_date']) &&
        !empty($input['checkout_date'])
      ) {
        // --
        $obj = $this->load_model('Reception');
        // --
        $bind = array(
          'id_room' => intval($input['id_room']),
          'checkin_date' => $input['checkin_date'],
          'checkout_date' => $input['checkout_date'],
        );
        // --
        $response = $obj->date_reservation($bind);
        // --
        switch ($response['status']) {
            // --
          case 'OK':
            // --
            $json = array(
              'status' => 'OK',
              'type' => 'success',
              'msg' => 'Fechas correctas.',
              'data' => $response['result']
            );
            // --
            break;

          case 'ERROR':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'warning',
              'msg' => 'La habitación ya está reservada para esas fechas.',
              'data' => $response['result']
            );
            // --
            break;

          case 'EXCEPTION':
            // --
            $json = array(
              'status' => 'ERROR',
              'type' => 'error',
              'msg' => $response['result']->getMessage(),
              'data' => array()
            );
            // --
            break;
        }
      } else {
        // --
        $json = array(
          'status' => 'ERROR',
          'type' => 'warning',
          'msg' => 'No se enviaron los campos necesarios, verificar.',
          'data' => array()
        );
      }
    } else {
      // --
      $json = array(
        'status' => 'ERROR',
        'type' => 'error',
        'msg' => 'Método no permitido.',
        'data' => array()
      );
    }

    // --
    header('Content-Type: application/json');
    echo json_encode($json);
  }
}
