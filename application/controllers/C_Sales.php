<?php
// --
class C_Sales extends Controller
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
    $this->functions->check_permissions($this->segment->get('modules'), 'Sales');
    // --
    $this->view->set_js('index');       // -- Load JS
    $this->view->set_menu(array('modules' => $this->segment->get('modules'), 'view' => 'Sales')); // -- Active Menu
    $this->view->set_view('index');     // -- Load View
  }
  public function get_reservation_by_id()
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
      if (!empty($input['id_reservation'])) {
        // --
        $obj = $this->load_model('Sales');
        // --
        $bind = array('id_reservation' => intval($input['id_reservation']));
        // --
        $response = $obj->get_reservation_by_id($bind);
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
}
