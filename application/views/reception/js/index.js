// WARNING: the updating of the rooms has an error in case the reservation has an error, the user is obliged to complete the missing fields
const colorsRooms = {
  Disponible: "#28C66F",
  Ocupado: "#EA5455",
  Limpieza: "#00C1FF",
  Reservado: "#FC912A",
  Libre: "#517FFF",
};

function generateRoomCardHTML(row) {
  const { room_status, id_room, type_name, person_limit, room_number } = row;

  const bgClass = colorsRooms[room_status] || "success";
  const isOccupied = room_status === "Ocupado";
  const isCleaning = room_status === "Limpieza";
  const isReservedOrOccupied = room_status === "Reservado" || isOccupied;
  const btnDisabled = room_status === "Libre" && "hidden";

  const btnTimerHTML = `<button class="btn bg-light text-dark btn-icon btn-md btn_timer" data-process-key="${id_room}">
                          <i class="fa-solid fa-clock"></i>
                        </button>`;
  const buttonCleanHTML = `<button class="btn bg-light text-dark btn-icon btn-md btn_clean ${isOccupied ? "hidden" : ""
    }" data-process-key="${id_room}" type="submit">
                              <i class="fa-solid fa-circle-check"></i>
                            </button>`;
  const stateCleaningHTML = isCleaning ? buttonCleanHTML : "";
  const statusButtonHTML = isReservedOrOccupied ? btnTimerHTML : "";

  return `<div class="card text-light" style="width: 18rem; background:${bgClass}; border-radius: 10px;">
              <div class="card-body">
                  <h5 class="card-title text-light" style="font-size: 1.5rem">${type_name}</h5>
                  <div class="d-flex align-items-center gap-1" style="font-size: 1.5rem">
                      <i class="fa-solid fa-people-group"></i>
                      <p class="card-text ml-2">${person_limit}</p>
                  </div>
                  <div class="text-center mt-2" style="font-size: 1.5rem">
                      ${room_status}
                  </div>
              </div>
              <div class="card-footer d-flex justify-content-between align-items-center" style="border-top: 1px solid rgba(255, 255, 255, 0.2); letter-spacing: 1px;">
                  <div class="d-flex align-items-center">
                      <i class="fa-solid fa-bed text-light" style="font-size: 2.3rem;"></i>
                      <span style="font-size: 1.5rem; margin-left: 5px;">${room_number}</span>
                  </div>
                  <div class="d-flex justify-content-center align-items-center gap-1">
                    <button class="btn bg-light text-dark btn-icon btn-md btn_update ${btnDisabled}" data-process-key="${id_room}">
                      <i class="fa-solid fa-key"></i>
                    </button>
                    ${statusButtonHTML}
                    ${stateCleaningHTML}
                  </div>
              </div>
          </div>`;
}

function displayRooms(data) {
  if (data.status === "OK") {
    $("#data-container").empty();

    data.data.forEach((row) => {
      const roomCardHTML = generateRoomCardHTML(row);
      $("#data-container").append(roomCardHTML);
    });

  }
}

function fetchRooms() {
  $.ajax({
    url: BASE_URL + "Reception/get_rooms",
    type: "GET",
    dataType: "json",
    cache: false,
    success: function (data) {
      if (data.status === "OK") {
        functions.toast_message("success", "Habitaciones listadas correctamente", "Exito");
        displayRooms(data);
      }
    },
    error: function (xhr, status, error) {
      console.error("Fallo al obtener los datos.");
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
}

function fetchRoomsStatus(status_room) {
  $.ajax({
    url: BASE_URL + "Reception/get_room_by_status",
    type: "GET",
    data: {
      room_status: status_room,
    },
    dataType: "json",
    cache: false,
    success: function (data) {
      if (data.status === "OK") {
        displayRooms(data);
      } else {
        functions.toast_message("warning", `No hay habitaciones en estado de ${status_room}`, "Advertencia");
        fetchRooms();
      }
    },
    error: function (xhr, status, error) {
      console.error("Fallo al obtener los datos.");
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
}

$("#btn_room_status").on("change", function () {
  const status = document.getElementById("btn_room_status").value;
  if (status == "0") {
    fetchRooms();
  } else {
    fetchRoomsStatus(status);
  }
});

function update_state_timer(form) {
  // --
  $("#btn_remove_reservation").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --
  $.ajax({
    url: BASE_URL + "Reception/update_state_timer",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    beforeSend: function () {
      console.log("Cargando...");
    },
    success: function (data) {
      // --
      if (data.status === "OK") {
        // --
        $("#timer_modal").modal("hide");
        form.reset();
        fetchRooms();
      } else {
        // --

        $("#btn_remove_reservation").prop("disabled", false);
      }
    },
    error: function (xhr, status, error) {
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
}


function create_reservation(form) {
  // --
  $("#btn_create_reservation").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --

  $.ajax({
    url: BASE_URL + "Reception/create_reservation",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    success: function (data) {
      // --
      if (data.status === "OK") {

        form.reset();
        filterOptions();
        // --
        $("#update_habitacion_modal").modal("hide");
        $("#btn_create_reservation").prop("disabled", false);
      } else {
        $("#btn_create_reservation").prop("disabled", false);
        functions.toast_message("error", "Error al obtener los datos", "Error");
      }
    },
    error: function (xhr, status, error) {
      console.log(error);
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
}

function create_reservation_free(form) {
  // --
  $("#btn_create_reservation").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --

  $.ajax({
    url: BASE_URL + "Reception/create_reservation_free",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    success: function (data) {
      // --
      if (data.status === "OK") {

        form.reset();
        filterOptions();
        // --
        $("#update_habitacion_modal").modal("hide");
        $("#btn_create_reservation").prop("disabled", false);
      } else {
        $("#btn_create_reservation").prop("disabled", false);
        functions.toast_message("error", "Error al obtener los datos", "Error");
      }
    },
    error: function (xhr, status, error) {
      functions.toast_message("error", "Error al obtener los datos", "Error", error);
    },
  });
}

function update_room(form) {
  // --
  $("#btn_create_reservation").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --
  $.ajax({
    url: BASE_URL + "Reception/update_state_reservation",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    beforeSend: function () {
      console.log("Cargando...");
    },
    success: function (data) {
      // --
      if (data.status === "OK") {
        // --
        $("#update_habitacion_modal").modal("hide");
        $("#btn_create_reservation").prop("disabled", false);
        form.reset();
      } else {
        // --
        $("#btn_create_reservation").prop("disabled", false);
      }
    },
    error: function (xhr, status, error) {
      console.log(error);
      functions.toast_message("error", "Error al obtener los datos", "Error");
    }
  });
}

$("#create_reservation_form").validate({
  // --

  submitHandler: function (form) {
    const room_status = $("#room_status_reservation").val();
    if (room_status === "Ocupado" || room_status === "Reservado") {
      create_reservation(form);
    } else {
      create_reservation_free(form);
    }
    update_room(form);
    fetchRooms();
  },
});

$('#room_status_reservation').change(function () {
  const checkout_date = document.querySelector('.checkout_date');
  const checkout_time = document.querySelector('.checkout_time');
  const pre_payment = document.querySelector('.pre_payment')
  const all_payment = document.querySelector('.all_payment');
  const status = document.getElementById("status");
  status.value = this.value;
  if (this.value === "Reservado" || this.value === "Ocupado") {
    checkout_date.classList.remove('hidden')
    checkout_time.classList.remove('hidden')
    pre_payment.classList.remove('hidden')
    all_payment.classList.remove('hidden')
    $('input[name="checkin_date"]').on("change", () => {
      valDate("checkin_date", "checkin_time");
    });
    $('input[name="checkin_time"]').on("change", () => {
      valDate("checkin_time");
    });
    $('input[name="checkout_date"]').on("change", () => {
      valDate("checkout_date", "checkout_time");
    });
    $('input[name="checkout_time"]').on("change", () => {
      valDate("checkout_time");
    });
  } else {
    checkout_date.classList.add('hidden')
    checkout_time.classList.add('hidden')
    pre_payment.classList.add('hidden')
    all_payment.classList.add('hidden')
  }
});

var allPricesRoom = [];

function valDate(input_name, input_nameAux) {
  const valCheckin =
    $("input[name=checkin_date]").val() +
    " " +
    $("input[name=checkin_time]").val();
  const valCheckout =
    $("input[name=checkout_date]").val() +
    " " +
    $("input[name=checkout_time]").val();
  const valDateInitial = $("input[name=checkin_date]").val();
  $("input[name=checkout_date]").attr("min", valDateInitial);

  $("input[name=checkout_date]").attr(
    "min",
    $("input[name=checkin_date]").val(),
  );
  $("input[name=checkin_date]").attr(
    "max",
    $("input[name=checkout_date]").val(),
  );

  const valRoom = $("input[name=id_room]").val();

  $.ajax({
    url: BASE_URL + "Reception/date_reservation",
    cache: false,
    data: {
      id_room: valRoom,
      checkin_date: valCheckin,
      checkout_date: valCheckout,
    },
    success: function (data) {
      const datas = data.data;
      if (data.status == "ERROR") {
        $("input[name=" + input_name + "]")
          .addClass("is-invalid")
          .attr("data-error", data.msg);
      } else if (data.status == "OK") {
        $("input[name=" + input_name + "]")
          .removeClass("is-invalid")
          .removeAttr("data-error");
        $("input[name=" + input_nameAux + "]")
          .removeClass("is-invalid")
          .removeAttr("data-error");
        paymentReservation(valCheckin, valCheckout, allPricesRoom, 1);
      }
    },
  });
}

function paymentReservation(dateIn, dateOut, prices) {
  let fechaInicio = new Date(dateIn);
  let fechaFin = new Date(dateOut);
  let milisegundosInicio = fechaInicio.getTime();
  let milisegundosFin = fechaFin.getTime();

  let minutes = (milisegundosFin - milisegundosInicio) / (1000 * 60);

  if (minutes <= 240) {
    $("input[name=payment_room]").val(prices[0]);
  } else if (minutes > 240 && minutes <= 720) {
    $("input[name=payment_room]").val(prices[1]);
  } else {
    let dias = Math.floor(minutes / 1440);
    let minutesRes = minutes % 1440;
    let payment = parseInt(prices[2]) * dias;
    let paymentMinutes = 0;

    // --
    if (minutesRes > 0 && minutesRes <= 240) {
      paymentMinutes = parseInt(prices[0]);
    } else if (minutesRes > 240 && minutesRes <= 720) {
      paymentMinutes = parseInt(prices[1]);
    } else {
      paymentMinutes = parseInt(prices[2]);
    }
    payment += paymentMinutes;

    return $("input[name=payment_room]").val(payment);
  }
}

function create_guest(form) {
  $("#btn_create_guest_reservation").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --
  $.ajax({
    url: BASE_URL + "Reception/create_guest_reservation",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    beforeSend: function () {
      console.log("Cargando...");
    },
    success: function (data) {
      // --
      if (data.status === "OK") {
        // --
        $("#create_guest_reservation_modal").modal("hide");
        form.reset();
        $("#btn_create_guest_reservation").prop("disabled", false);
        filterOptions();
        fetchRooms();
      } else {
        // --
        $("#btn_create_guest_reservation").prop("disabled", false);
      }
    },
  });
}

$(document).on("click", ".btn_timer", function () {
  // --
  let value = $(this).attr("data-process-key");
  // --
  let params = { id_room: value };

  // --
  $.ajax({
    url: BASE_URL + "Reception/get_room_by_id",
    type: "GET",
    data: params,
    dataType: "json",
    contentType: false,
    processData: true,
    cache: false,
    success: function (data) {
      // --
      // console.log(data);

      if (data.status === "OK") {
        // --
        let item = data.data;
        // --
        let id_timer_room = item.id_room;
        listReservation(id_timer_room);
        $("#create_timer_form :input[name=id_room]").val(item.id_room);
        $("#create_timer_form :input[name=room_number]").val(item.room_number);
        $("#create_timer_form :input[name=room_status]").val(item.room_status);
        $("#create_timer_form :input[name=type_name]").val(item.type_name);
      }
    },
    error: function () {

      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
  // --
  $("#timer_modal").modal("show");
});

// -- Funciones

function filterOptions() {
  const client_document_type = $("#client_document_type").val();
  $.ajax({
    url: BASE_URL + "Reception/get_guest",
    type: "GET",
    data: { document_type: client_document_type },
    dataType: "json", // Espera una respuesta JSON
    cache: false,
    success: function (data) {
      if (data.status === "OK") {
        $(".opcionesSelect").empty();

        $.each(data.data, function (index, row) {
          const optionText =
            client_document_type === "DNI" && row.document_type === "DNI"
              ? `${row.first_names} ${row.last_names}`
              : row.company_name;
          $(".opcionesSelect").append(`
                  <option value=${row.id_guest}>
                    ${optionText}
                  </option >
        `);
        });
      } else {
      }
    },
  });
}


$("#client_document_type").on("change", function () {
  filterOptions();
});

function listReservation(room_id) {
  let id_room = room_id;
  $.ajax({
    url: BASE_URL + "Reception/get_reservation_room",
    type: "GET",
    data: { id_room: id_room },
    dataType: "json",
    cache: false,
    success: function (data) {
      if (data.status === "OK") {
        $.each(data.data, function (index, row) {
          const guestNames = row.first_names + " " + row.last_names;
          const condition = row.company_name ? row.company_name : guestNames;
          $(".optionReservation").append(`
            <option value=${row.id_reservation}>
            ${condition}
            </option>
            `);
        });

      } else {
        $(".optionReservation").empty();
      }
    },
    error: function (xhr, status, error) {
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
}


function clean_rooms(form) {
  $("#btn_clean_rooms").prop("disabled", true);
  // --
  let params = new FormData(form);
  // --
  $.ajax({
    url: BASE_URL + "Reception/clean_rooms",
    type: "POST",
    data: params,
    dataType: "json",
    contentType: false,
    processData: false,
    cache: false,
    beforeSend: function () {
      console.log("Cargando...");
    },
    success: function (data) {
      $("#clean_modal").modal("hide");
      $("#btn_clean_rooms").prop("disabled", false);
      filterOptions();
      fetchRooms();
    },
    error: function (xhr, status, error) {
      functions.toast_message("error", "Error al obtener los datos", "Error");
    }
  });
}
$(document).on("click", ".btn_clean", function () {
  let value = $(this).attr("data-process-key");
  $("#clean_form :input[name=id_room]").val(value);
  $("#clean_modal").modal("show");
});

$("#clean_form").validate({
  submitHandler: function (form) {
    clean_rooms(form);
  },
});

//------------------------------
$(document).on("click", ".btn_update", function () {
  // --
  let value = $(this).attr("data-process-key");
  // --
  let params = { id_room: value };

  // --
  $.ajax({
    url: BASE_URL + "Reception/get_room_by_id",
    type: "GET",
    data: params,
    dataType: "json",
    contentType: false,
    processData: true,
    cache: false,
    success: function (data) {
      // --

      if (data.status === "OK") {
        // --
        let item = data.data;
        // --
        $("#create_reservation_form :input[name=room_number]").val(
          item.room_number,
        );
        $("#create_reservation_form :input[name=type_name]").val(
          item.type_name,
        );
        $("#create_reservation_form :input[name=person_limit]").val(
          item.person_limit,
        );
        $("#create_reservation_form :input[name=bed_type]").val(item.bed_type);
        $("#create_reservation_form :input[name=price_temporary]").val(
          item.price_temporary,
        );
        $("#create_reservation_form :input[name=price_half]").val(
          item.price_half,
        );
        $("#create_reservation_form :input[name=price_day]").val(
          item.price_day,
        );
        $("#create_reservation_form :input[name=id_room]").val(item.id_room);
        allPricesRoom.push(item.price_temporary);
        allPricesRoom.push(item.price_half);
        allPricesRoom.push(item.price_day);
      }
    },
    error: function () {
      functions.toast_message("error", "Error al obtener los datos", "Error");
    },
  });
  // --
  $("#update_habitacion_modal").modal("show");
});

function reservationDocument() {
  const documentType = document.getElementById("client_document_type");
  const document_number = document.getElementById(
    "document_number_reservation",
  );

  documentType.addEventListener("change", function () {
    const documentNumberInput = document.getElementById(
      "document_number_reservation",
    );
    const selectedDocumentType = this.value;

    if (selectedDocumentType === "DNI") {
      documentNumberInput.maxLength = 8;
    } else if (selectedDocumentType === "RUC") {
      documentNumberInput.maxLength = 11;
    } else {
      documentNumberInput.maxLength = 8;
    }
  });

  document_number.addEventListener("input", function () {
    this.value = this.value.replace(/[^0-9]/g, "");
  });
}

// -- Reset forms
$(document).on("click", ".reset", function () {
  $("#create_reservation_form").validate().resetForm();
  // --
  $("#create_guest_reservation_form").validate().resetForm();
  $("#create_timer_form").validate().resetForm();
  $("#clean_form").validate().resetForm();
});

// -- Validate form
$("#create_guest_reservation_form").validate({
  // --
  submitHandler: function (form) {
    create_guest(form);
    fetchRooms();
  },
});

$("#create_timer_form").validate({
  // --
  submitHandler: function (form) {
    update_state_timer(form);
    fetchRooms();
  },
});
var inputStartDate = document.getElementById("fechaInicio");
var inputEndDate = document.getElementById("fechaFin");

var currentDate = new Date().toISOString().split("T")[0];

inputStartDate.setAttribute("min", currentDate);
inputEndDate.setAttribute("min", currentDate);

function guestDocument() {
  const documentType = document.getElementById("client_document");

  documentType.addEventListener("change", function () {
    const documentNumberInput = document.getElementById("document_number");
    const selectedDocumentType = this.value;

    if (selectedDocumentType === "DNI") {
      documentNumberInput.maxLength = 8;
    } else {
      documentNumberInput.maxLength = 11;
    }
  });

  document_number.addEventListener("input", function () {
    this.value = this.value.replace(/[^0-9]/g, "");
  });
}
//TODO: MEJORA PENDIENTE
function get_api() {
  const number_document = document.getElementById("document_number").value;
  const guestDocumentType = document.getElementById("client_document").value;

  if (guestDocumentType === "DNI") {
    fetch("https://consultardoc.ceatec.com.pe/dni/" + number_document)
      .then((response) => response.json())
      .then(function (data) {
        let first_names = `${data.nombres}`;
        let last_names = `${data.apellido_paterno} ${data.apellido_materno}`;
        const firstNameDocument = document.getElementById("nombre");
        const lastNameDocument = document.getElementById("apellido");
        const razon_social = document.getElementById("razon_social");

        razon_social.value = " ";

        firstNameDocument.value = first_names;
        lastNameDocument.value = last_names;
      })
      .catch(function (error) {
        console.error("Ha ocurrido un error");
        $('#errorModal').modal('show'); // Mostrar modal de error
      }); 
  } else {
    // Muchachos, introduzcan el api key de la validación  de ruc, por que ya se vence "https://dniruc.apisperu.com/api/v1/ruc/" en este link reclama la nueva api key
    fetch(
      "https://dniruc.apisperu.com/api/v1/ruc/" +
      number_document +
      "?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImRlbm9ibzU2OThAbG9jYXdpbi5jb20ifQ.EyjRFR8bKyCk6kFslAqpFp4Lu4p7VdixEjZy8NEJDRI",
    )
      .then((response) => response.json())
      .then((data) => {
        if (data.success === false) {
          $('#errorModal').modal('show'); // Mostrar modal de error
        } else {
          const razonSocial = data.razonSocial;
          const addressRuc = data.direccion;
          const razon_social = document.getElementById("razon_social");
          const address = document.getElementById("direccion");
          const firstNameDocument = document.getElementById("nombre");
          const lastNameDocument = document.getElementById("apellido");

          firstNameDocument.value = " ";
          lastNameDocument.value = " ";
          razon_social.value = razonSocial;
          address.value = addressRuc;
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        $('#errorModal').modal('show'); // Mostrar modal de error
      });
  }
}

document
  .getElementById("client_document")
  .addEventListener("change", function () {
    const guestDocumentType = document.getElementById("client_document").value;
    const div_razon_social = document.getElementById("div_razon_social");
    const div_first_names = document.getElementById("div_nombre");
    const div_last_names = document.getElementById("div_apellido");

    if (guestDocumentType === "DNI") {
      div_razon_social.style.display = "none";
      div_last_names.style.display = "block";
      div_first_names.style.display = "block";
    } else if (guestDocumentType === "RUC") {
      div_last_names.style.display = "none";
      div_first_names.style.display = "none";
      div_razon_social.style.display = "block";
    }
  });

$("#buscar_huesped").on("click", function (e) {
  e.preventDefault();
  get_api();
});

guestDocument();

$(document).ready(function () {
  $('.bs-popover').popover();
});

// Cargar habitaciones al iniciar
fetchRooms();
